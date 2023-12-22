FROM golang:1.19 as builder
RUN  go env -w GOPROXY=https://goproxy.io,direct
RUN  go env -w GO111MODULE=on
WORKDIR .
COPY . .
RUN ls
RUN pwd
RUN make build

FROM alpine:3.18
COPY --from=builder /go/src/sigs.k8s.io/prometheus-adapter/adapter /
USER 65534
ENTRYPOINT ["/adapter"]