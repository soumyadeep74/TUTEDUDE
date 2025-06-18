from flask import Flask, request, render_template, jsonify
import json
import os
from datetime import datetime

app = Flask(__name__)

@app.route('/')
def home():
    day_of_week = datetime.now().strftime('%A %d %B %Y')
    current_time = datetime.now().strftime('%H:%M:%S')
    return f"Hello from backend-test! Today is {day_of_week}"

@app.route('/submit', methods=['POST'])
def submit():
    name = request.form['name']
    email = request.form['email']
    password = request.form['password']

    with open('names.txt', 'a') as f:
        f.write(f'Name: {name}, Email: {email}, Password: {password}\n')

    return render_template('success.html')

@app.route('/view', methods=['GET'])
def view():
    try:
        with open('names.txt', 'r') as file:
            lines = file.readlines()
        return jsonify({"entries": lines}), 200
    except FileNotFoundError:
        return jsonify({"error": "Data file not found"}), 404

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
