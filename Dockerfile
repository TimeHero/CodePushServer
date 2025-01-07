FROM alpine:latest AS go-system

LABEL description="Run code-push-server-go"

# Add go
RUN wget https://go.dev/dl/go1.23.4.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go1.23.4.linux-amd64.tar.gz
ENV PATH=$PATH:/usr/local/go/bin

FROM go-system AS codepush-go

# Add mysql
RUN apk add --no-cache mariadb-client

# Add redis
RUN apk add --no-cache redis

# Add code-push-server-go
WORKDIR /server
RUN wget https://github.com/htdcx/code-push-server-go/releases/download/v1.0.5/code-push-server-go_Linux_arm64.tar.gz
RUN tar -xzf code-push-server-go_Linux_arm64.tar.gz -C /server
COPY ./config ./config

ARG SERVER_CONFIG

# Add the config based on the SERVER_CONFIG environment variable
RUN rm -f config/app.json && touch config/app.json
RUN echo "{\"mode\":\"$SERVER_CONFIG\"}" > config/app.json

RUN chmod +x code-push-server-go
EXPOSE 8080

CMD ["/server/code-push-server-go"]
