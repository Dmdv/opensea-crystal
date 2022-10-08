FROM crystallang/crystal:latest as builder
WORKDIR /app

# RUN apt-get update -qq && apt-get install -y --no-install-recommends libpq-dev libsqlite3-dev libmysqlclient-dev libreadline-dev git curl vim netcat

COPY ./shard.yml ./shard.lock /app/
RUN shards install --production -v

COPY . /app/
RUN shards build --static --no-debug --release --production -v

FROM alpine
EXPOSE 3000

# that will fix DNS resolve issue in docker
COPY --from=builder /lib/x86_64-linux-gnu/libnss_dns.so /lib/x86_64-linux-gnu/
COPY --from=builder /lib/x86_64-linux-gnu/libresolv.so.2  /lib/x86_64-linux-gnu/
COPY --from=builder /lib/x86_64-linux-gnu/libnss_dns.so /lib/x86_64-linux-gnu/
COPY --from=builder /lib/x86_64-linux-gnu/libresolv.so.2  /lib/x86_64-linux-gnu/

# app
COPY --from=builder /app/bin/opensea /opensea

ENTRYPOINT ["/opensea"]