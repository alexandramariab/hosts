#!/bin/bash


# Citesc fiecare linie din /etc/hosts
cat /etc/hosts | while read -r ip hostname rest; do
    
    # ignor liniile goale și liniile care încep cu # (comentarii)
    if [[ "$ip" =~ ^# ]] || [[ -z "$ip" ]]; then
        continue
    fi

    # Verific IP-ul real cu nslookup
    #    - Se filtreaza doar liniile care incep cu "Address:"
    #    - Se foloseste tail -n 1 pentru a lua ultima adresa (care este de obicei IP-ul gazdei, nu serverul DNS)    
    bun_ip=$(nslookup "$hostname" 2>/dev/null | \
                  awk '/^Address: / { print $2 }' | tail -n 1)        
        # Dacă nslookup returnează ceva și e diferit de IP-ul din hosts
        if [[ -n "$bun_ip" ]] && [[ "$bun_ip" != "$ip" ]]; then
            echo "Bogus IP for $hostname in /etc/hosts!"
        fi
done

