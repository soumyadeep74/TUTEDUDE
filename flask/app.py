import pymongo
import os
from flask import Flask, request, render_template
from datetime import datetime
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi
from dotenv import load_dotenv

load_dotenv()
MONGO_URI = os.getenv('MONGO_URI')
client = pymongo.MongoClient(MONGO_URI, server_api=ServerApi('1'))
# Ensure the connection is established
db = client.test
collection = db['test_collection']

# Initialize Flask app
app = Flask(__name__)

@app.route('/')
def home():
    day_of_week = datetime.now().strftime('%A %d %B %Y')
    return render_template('index.html', day_of_week=day_of_week)

@app.route('/submit', methods=['POST'])
def submit():
    form_data = request.form.to_dict()
    collection.insert_one(form_data)  # Save form data to MongoDB
    return render_template('success.html', data=form_data)
    #name = request.form.get('name')
    #return f"Welcome {name}! to demo page.<br>You have submitted the form successfully."

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
