
FROM docker.io/library/golang:1.22 AS base

WORKDIR /app

COPY go.mod .
RUN go mod download

COPY . .
RUN go build -o main .

FROM gcr.io/distroless/base:latest
COPY --from=base /app/main /main
COPY --from=base /app/static /static

CMD ["/main"]
