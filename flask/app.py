from flask import Flask, request, render_template
from datetime import datetime
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi

# MongoDB connection URI
uri = "mongodb+srv://test:abcd1234@cluster0.sdyhpi5.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"

# Create a new client and connect to the server
client = MongoClient(uri, server_api=ServerApi('1'))

# Ping to confirm connection
try:
    client.admin.command('ping')
    print("Pinged your deployment. You successfully connected to MongoDB!")
except Exception as e:
    print(e)

# Initialize Flask app
app = Flask(__name__)

@app.route('/')
def home():
    day_of_week = datetime.now().strftime('%A %d %B %Y')
    return render_template('index.html', day_of_week=day_of_week)

@app.route('/submit', methods=['POST'])
def submit():
    name = request.form.get('name')
    return f"Welcome {name}! to demo page.<br>You have submitted the form successfully."

# Optional routes (currently commented out for clarity)

# @app.route('/api/<name>')
# def second(name):
#     length = len(name)
#     if length < 5:
#         return "Name is fine"
#     else:
#         return "Name is too long"
#     result = f"Hello! {name}, welcome to my page"
#     return result

# @app.route('/add/<a>/<b>')
# def add(a, b):
#     try:
#         result = int(a) + int(b)
#         return f"The sum of {a} and {b} is {result}"
#     except ValueError:
#         return "Please provide valid integers."

# @app.route('/api')
# def get_user_info():
#     name = request.values.get('name')
#     age = request.values.get('age')
#     result = {
#         'name': name,
#         'age': age
#     }
#     return result

# Run the app
if __name__ == '__main__':
    app.run(debug=True)
