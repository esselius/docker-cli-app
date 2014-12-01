FROM debian:jessie

RUN apt-get -y update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["script/router"]

ADD . /app
