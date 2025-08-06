#!/bin/bash

# Update and install necessary packages
apt update -y
apt install -y python3-pip python3-venv nodejs npm

# ---------------- Flask Setup ----------------
mkdir -p /home/ubuntu/backend
cd /home/ubuntu/backend

python3 -m venv venv
/home/ubuntu/backend/venv/bin/pip install flask

cat <<EOF > /home/ubuntu/backend/app.py
from flask import Flask
app = Flask(__name__)
@app.route('/')
def hello():
    return "Hello from Flask!"
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
EOF

nohup /home/ubuntu/backend/venv/bin/python /home/ubuntu/backend/app.py > /home/ubuntu/backend.log 2>&1 &

# ---------------- Express Setup ----------------
mkdir -p /home/ubuntu/frontend
cd /home/ubuntu/frontend

cat <<EOF > index.js
const express = require('express');
const app = express();
app.get('/', (req, res) => {
    res.send('Hello from Express!');
});
app.listen(3000, () => {
    console.log('Express app listening on port 3000');
});
EOF

npm init -y
npm install express

nohup node index.js > /home/ubuntu/frontend.log 2>&1 &
