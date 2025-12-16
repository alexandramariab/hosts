#!/bin/bash

# Functia ceruta: verifica asocierea IP folosind un server DNS specific
# Parametri: $1=hostname, $2=IP_din_hosts, $3=server_DNS
check_association() {
    local host=$1
    local local_ip=$2
    local dns_srv=$3

    # nslookup foloseste al doilea argument ca server DNS de interogat
    local dns_ip=$(nslookup "$host" "$dns_srv" 2>/dev/null | awk '/^Address: / { print $2 }' | tail -n 1)

    if [[ -n "$dns_ip" ]] && [[ "$dns_ip" != "$local_ip" ]]; then
        echo "Bogus IP for $host in /etc/hosts! (DNS $dns_srv found $dns_ip)"
    fi
}

# Serverul DNS pe care vrem sa il folosim (ex: Google)
MY_DNS="8.8.8.8"

cat /etc/hosts | while read -r ip hostname rest; do
    [[ "$ip" =~ ^# ]] || [[ -z "$ip" ]] && continue
    [[ "$hostname" == "localhost" ]] && continue

    # Apelam functia cu cei 3 parametri
    check_association "$hostname" "$ip" "$MY_DNS"
done
