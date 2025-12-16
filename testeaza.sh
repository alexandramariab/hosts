#!/bin/bash
# Varianta initiala a scriptului

cat /etc/hosts | while read -r ip hostname rest; do
    [[ "$ip" =~ ^# ]] || [[ -z "$ip" ]] && continue
    
    # Excludem localhost
    [[ "$hostname" == "localhost" ]] && continue

    resolved_ip=$(nslookup "$hostname" 2>/dev/null | awk '/^Address: / { print $2 }' | tail -n 1)

    if [[ -n "$resolved_ip" ]] && [[ "$resolved_ip" != "$ip" ]]; then
        echo "Bogus IP for $hostname in /etc/hosts!"
    fi
done
