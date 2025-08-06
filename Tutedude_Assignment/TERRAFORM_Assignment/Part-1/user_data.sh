#!/bin/bash
# Update and install necessary packages
sudo apt update -y
sudo apt install -y python3-pip nodejs npm
sudo pip3 install flask

# Setup Flask backend
mkdir -p /home/ubuntu/backend
cat <<EOF > /home/ubuntu/backend/app.py
from flask import Flask
app = Flask(__name__)
@app.route('/')
def hello():
    return "Hello from Flask!"
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
EOF
pip3 install flask
nohup python3 /home/ubuntu/backend/app.py > /home/ubuntu/backend.log 2>&1 &

# Setup Express frontend
mkdir -p /home/ubuntu/frontend
cat <<EOF > /home/ubuntu/frontend/index.js
const express = require('express');
const app = express();
app.get('/', (req, res) => {
    res.send('Hello from Express!');
});
app.listen(3000, () => {
    console.log('Express app listening on port 3000');
});
EOF
cd /home/ubuntu/frontend
npm init -y
npm install express
nohup node index.js > /home/ubuntu/frontend.log 2>&1 &
