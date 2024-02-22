FROM golang:1.19 as builder
ENV GOPATH /gopath/
ENV PATH $GOPATH/bin/$PATH
COPY . /go/src/prometheus-adapter/
WORKDIR /go/src/prometheus-adapter/
RUN ls -a
RUN make build

FROM alpine:latest
COPY --from=builder /go/src/sigs.k8s.io/prometheus-adapter/adapter /
USER 65534
ENTRYPOINT ["/adapter"]