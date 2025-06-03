from flask import Flask, request, render_template, jsonify
from datetime import datetime
import json

# Initialize Flask app
app = Flask(__name__)

@app.route('/api', methods=['GET'])
def api():
    try:
        with open('data.json', 'r') as file:
            data = json.load(file)
        return jsonify(data)
    except FileNotFoundError:
        return jsonify({"error": "Data file not found"}), 404


if __name__ == '__main__':
    app.run(debug=True)