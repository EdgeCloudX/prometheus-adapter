FROM golang:1.18 as builder
RUN  go env -w GOPROXY=https://goproxy.io,direct
RUN  go env -w GO111MODULE=on
WORKDIR .
COPY . .
RUN make build

FROM alpine:3.18
COPY --from=builder /go/src/sigs.k8s.io/prometheus-adapter/adapter /
USER 65534
ENTRYPOINT ["/adapter"]