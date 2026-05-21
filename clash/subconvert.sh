#!/usr/bin/env bash

subscription_link="$1"
subconvertor_url="http://127.0.0.1:25500/sub"
config_url="https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/\
Clash/config/ACL4SSR_Online_Full_AdblockPlus.ini"
output_dir="$(mktemp -d /tmp/subconvert-XXXXXX)"
current_date="$(date +%F)"
output_file="$output_dir/clash-config-${current_date}.yml"

if ! docker ps -a --format '{{.Names}}' | grep -Fxq subconverter; then
    echo "Docker container subconverter does not exist. Creating it."
    docker run -d --restart=always --name subconverter \
        -p 25500:25500 tindy2013/subconverter:latest
else
    echo "Docker container subconverter already exists."
fi

curl --silent --show-error --output "$output_file" --get \
    "$subconvertor_url" \
    --data-urlencode "target=clash" \
    --data-urlencode "url=$subscription_link" \
    --data-urlencode "insert=false" \
    --data-urlencode "config=$config_url"

echo "Saved response body to: $output_file"
