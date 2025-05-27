from flask import Flask,request, render_template
from datetime import datetime

app = Flask(__name__)

@app.route('/')
def home():

    day_of_week = datetime.now().strftime('%A')  +  datetime.now().strftime(' %d %B %Y')
    #return "Welcome to my page"
    return render_template('index.html', day_of_week=day_of_week)




#@app.route('/api/<name>')
#def second(name):
    #length = len(name)

    #if length < 5:
       # return "Name is fine"
   # else :
        #return "Name is too long"
    result = "Hello! " + name + " welcome to my page"
    return result
#@app.route('/add/<a>/<b>')
#def add(a, b):
   # try:
     #   result = int(a) + int(b)
      #  return f"The sum of {a} and {b} is {result}"
   # except ValueError:
       # return "Please provide valid integers."
#def add(a, b):

    #answer = int(a) + int(b)
    #result = {
        #'ans' : answer
    #}
   # return result
#@app.route('/api')
#def name():
    #name = request.values.get('name')
    #age = request.values.get('age')
    #result ={
      #  'name': name,
      #  'age': age
   # }
   # return result
if __name__ == '__main__':
    app.run(debug=True)
# This code initializes a Flask application and defines a single route that returns "Hello, World!" when accessed.

