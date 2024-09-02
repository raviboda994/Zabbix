#!/bin/bash
websites="$1"
IFS=',' read -ra WEBSITE_ARRAY <<< "$websites"

echo -n '{"data":['
first=true
for website in "${WEBSITE_ARRAY[@]}"; do
    if $first; then
        first=false
    else
        echo -n ','
    fi
    echo -n "{\"{#WEBSITE}\":\"$website\"}"
done
echo -n ']}'
