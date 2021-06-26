FROM golang:1.16.5 as builder

WORKDIR /go/app

COPY ./app .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
    go build -ldflags="-w -s" -o /go/bin/app_runner

FROM scratch

COPY --from=builder /go/bin/app_runner /go/bin/app_runner

ENTRYPOINT [ "/go/bin/app_runner" ]