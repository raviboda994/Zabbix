#!/bin/bash

# Extract the domain name from the URL argument
domain=$(echo "$1" | awk -F/ '{print $3}')

# If no domain is found, assume the entire argument is the domain
if [ -z "$domain" ]; then
    domain="$1"
fi

# Attempt to retrieve SSL certificate expiration date
data=$(echo | openssl s_client -servername "$domain" -connect "$domain:${2:-443}" 2>/dev/null | openssl x509 -noout -enddate 2>/dev/null | sed -e 's#notAfter=##')

# Check if data retrieval was successful
if [ -z "$data" ]; then
    echo 0
    exit 1
fi

# Convert the expiration date to seconds since epoch
ssldate=$(date -d "$data" '+%s' 2>/dev/null)

# Check if date conversion was successful
if [ $? -ne 0 ]; then
    echo 0
    exit 1
fi

# Get the current date in seconds since epoch
nowdate=$(date '+%s')

# Calculate the difference in days
diff=$((ssldate - nowdate))

# Output the difference in days
echo $((diff / 24 / 3600))
