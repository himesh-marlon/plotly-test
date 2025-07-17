FROM python:3.10-slim

# Install nginx
RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements file and install Python dependencies
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copy all files (index.html, main.py if it exists)
COPY . /app

# Expose port 3000
EXPOSE 3000

# Add nginx config dynamically
RUN printf "server {\n\
    listen 3000;\n\
    location / {\n\
        root /app;\n\
        index index.html;\n\
        try_files \$uri \$uri/ =404;\n\
    }\n\
}\n" > /etc/nginx/conf.d/default.conf

# Add startup script inside container
RUN printf '#!/bin/sh\n\
if [ -f /app/main.py ]; then\n\
  echo "Running main.py..."\n\
  python /app/main.py\n\
fi\n\
nginx -g "daemon off;"\n' > /start.sh \
 && chmod +x /start.sh

# Use JSON form for CMD to avoid warning
CMD ["/start.sh"]
