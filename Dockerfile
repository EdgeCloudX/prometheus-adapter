FROM golang:1.19 as builder
RUN go version
RUN  go env -w GOPROXY=https://goproxy.io,direct
RUN  go env -w GO111MODULE=on

COPY go.mod .
RUN go mod download

COPY pkg pkg
COPY cmd cmd
COPY Makefile Makefile

RUN make build

FROM alpine:3.18
COPY --from=builder /go/src/sigs.k8s.io/prometheus-adapter/adapter /
USER 65534
ENTRYPOINT ["/adapter"]