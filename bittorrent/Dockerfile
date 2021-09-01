FROM golang:1.17-buster AS builder

# https://github.com/anacrolix/torrent/blob/master/.github/workflows/go.yml

RUN git clone https://github.com/anacrolix/torrent.git && cd ./torrent && go install ./cmd/...


FROM debian:buster-slim

COPY --from=builder /go/bin/* /usr/local/bin/
