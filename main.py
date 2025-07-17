import plotly.graph_objects as go
import plotly.express as px

# Sample data
x_data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
y_data = [2, 5, 3, 8, 7, 6, 9, 12, 8, 11]

# Create a simple line plot
fig = go.Figure(data=go.Scatter(x=x_data, y=y_data, mode='lines+markers', name='Sample Data'))

# Customize the layout
fig.update_layout(
    title='Simple Plotly Line Graph',
    xaxis_title='X Values',
    yaxis_title='Y Values',
    showlegend=True
)

# Save directly to HTML file
fig.write_html("index.html")

print("HTML file 'graph.html' has been created!")
