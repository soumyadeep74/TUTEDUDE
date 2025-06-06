FROM node:20-alpine

WORKDIR /app

RUN touch test.txt

RUN echo "Hello world" >> test.txt

RUN cat test.txt

ADD . .

#ENTRYPOINT ["node"]

#CMD ["node" , "app.js"] 

#if using entrypoint then :

#CMD ["cat test.txt" && "app.js"]
CMD cat test.txt && node app.js
