#!/bin/sh

set -e

echo "Starting Tailscale..."

tailscaled \
  --tun=userspace-networking \
  --socks5-server=127.0.0.1:1055 \
  --outbound-http-proxy-listen=127.0.0.1:1055 &

sleep 5

tailscale up --auth-key="$TS_AUTHKEY"

echo "Tailscale started."

sleep 3

echo "Starting Spring Boot..."

ALL_PROXY=socks5://127.0.0.1:1055/ \
HTTP_PROXY=http://127.0.0.1:1055/ \
http_proxy=http://127.0.0.1:1055/ \
java -Xms128m -Xmx256m -jar target/*.jar