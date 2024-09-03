#!/bin/bash

# Usage: check_website.sh <website_url>
website_url="$1"

# Perform an HTTP request and measure the response time in seconds
response=$(curl -o /dev/null -s -w "%{http_code} %{time_total}\n" "$website_url")

# Extract HTTP status code and response time
http_code=$(echo "$response" | awk '{print $1}')
response_time=$(echo "$response" | awk '{print $2}')

# Determine uptime status
if [ "$http_code" -eq 200 ]; then
    uptime_status=1
else
    uptime_status=0
fi

# Convert response time from seconds to milliseconds
response_time_ms=$(echo "$response_time * 1000" | bc)

# Output the JSON data
echo "{\"uptime_status\": \"$uptime_status\", \"http_code\": \"$http_code\", \"response_time_ms\": \"$response_time_ms\"}"
