FROM golang:1.9

RUN apt-get update
RUN apt-get install -y nodejs

COPY . /app
WORKDIR /app

RUN go get github.com/gpestana/envaws
RUN go install github.com/gpestana/envaws

ENTRYPOINT envaws -conf configs.json -command "./app.sh"
