FROM node:alpine

RUN mkdir /project
COPY . /project

WORKDIR /project

RUN npm install

ENTRYPOINT node index.js
