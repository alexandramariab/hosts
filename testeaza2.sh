#!/bin/bash

# Functie pentru verificarea unui host folosind un DNS specific
check_ip() {
    local host="$1"
    local expected_ip="$2"
    local dns_server="$3"

    bun_ip=$(nslookup "$host" "$dns_server" 2>/dev/null | awk '/^Address: / {print $2}' | tail -n1)

    if [[ -n "$bun_ip" ]] && [[ "$bun_ip" != "$expected_ip" ]]; then
        echo "Bogus IP for $host in /etc/hosts!"
    fi
}

DNS_SERVER="8.8.8.8"

cat /etc/hosts | while read ip hostname rest; do
    [[ "$ip" =~ ^# ]] && continue
    [[ -z "$ip" ]] && continue

    check_ip "$hostname" "$ip" "$DNS_SERVER"
done

