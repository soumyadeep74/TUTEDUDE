from flask import Flask, request, render_template, jsonify
import json
import os

app = Flask(__name__)

@app.route('/submit', methods=['POST'])
def submit():
    name = request.form['name']
    email = request.form['email']
    password = request.form['password']

    with open('names.txt', 'a') as f:
        f.write(f'Name: {name}, Email: {email}, Password: {password}\n')

    return render_template('success.html')
    #return 'Data saved successfully!', 200

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
