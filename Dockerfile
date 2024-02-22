FROM golang:1.19 as builder
ENV GOPATH /gopath/
ENV PATH $GOPATH/bin/$PATH
RUN  go env -w GOPROXY=https://goproxy.io,direct
RUN  go env -w GO111MODULE=on
WORKDIR go/src
COPY . go/src
RUN ls
RUN pwd
RUN make build

FROM alpine:latest
COPY --from=builder /go/src/sigs.k8s.io/prometheus-adapter/adapter /
USER 65534
ENTRYPOINT ["/adapter"]