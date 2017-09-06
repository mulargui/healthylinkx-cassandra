FROM ubuntu:latest

RUN DEBIAN_FRONTEND=noninteractive 

# Install node.js, and supplementary programs
RUN apt-get -qq update && apt-get -y -qq install nodejs npm nodejs-legacy
RUN npm install -g cassandra-driver wait.for

ENV NODE_PATH=/usr/local/lib/node_modules
 
EXPOSE 8081

# By default, simply start the app
CMD node /myapp/index.js
