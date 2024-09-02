#!/bin/bash
ports="$1"
IFS=',' read -ra PORT_ARRAY <<< "$ports"

echo -n '{"data":['
first=true
for port in "${PORT_ARRAY[@]}"; do
    if $first; then
        first=false
    else
        echo -n ','
    fi
    echo -n "{\"{#PORT}\":\"$port\"}"
done
echo -n ']}'