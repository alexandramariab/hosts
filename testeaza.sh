#!/bin/bash

cat /etc/hosts | while read ip hostname; do
    bun_ip=$(nslookup $hostname | awk '/^Address: / { print $2 }')
    if [ "$bun_ip" != "$ip" ]; then
        echo "Bogus IP for $hostname in /etc/hosts!"
    fi
done

