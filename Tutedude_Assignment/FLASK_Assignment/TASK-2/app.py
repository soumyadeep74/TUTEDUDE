import pymongo
import os
import json
from flask import Flask, request, render_template, jsonify
from datetime import datetime
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi
from dotenv import load_dotenv

load_dotenv()
MONGO_URI = os.getenv('MONGO_URI')
client = pymongo.MongoClient(MONGO_URI, server_api=ServerApi('1'))

db = client.task2
collection = db['task2_collection']

app = Flask(__name__)

@app.route('/')
def home():
    day_of_week = datetime.now().strftime('%A %d %B %Y')
    current_time = datetime.now().strftime('%H:%M:%S')
    return render_template('index.html', day_of_week=day_of_week, current_time=current_time)

@app.route('/submit', methods=['POST'])
def submit():
    form_data = request.form.to_dict()
    collection.insert_one(form_data)
    return render_template('success.html', data=form_data)

@app.route('/view')
def view():
    data = collection.find()
    data = list(data)
    for item in data:
        del item['_id']
    data = {
        'data': data
    }
    return jsonify(data)
    
if __name__ == '__main__':
    app.run(debug=True)
