# syntax=docker/dockerfile:1
FROM golang:1.23-alpine AS build
WORKDIR /src
COPY go.mod ./
COPY main.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -trimpath -ldflags="-s -w" -o /out/hello-ping .

FROM gcr.io/distroless/static-debian12:nonroot
COPY --from=build /out/hello-ping /hello-ping
EXPOSE 8080
USER nonroot:nonroot
ENTRYPOINT ["/hello-ping"]
