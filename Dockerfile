FROM golang:1.21.4 as builder
WORKDIR /app
COPY . .
RUN go mod init ReverseProxy \
    && go get -d -v ./... \
    && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o ReverseProxy .

FROM scratch
WORKDIR /app
COPY --from=builder /app/ReverseProxy /app/ReverseProxy
EXPOSE 8888
ENTRYPOINT ["./ReverseProxy"]
