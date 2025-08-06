#!/bin/bash
apt update -y
apt install -y python3-pip python3-venv

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