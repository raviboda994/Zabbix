#!/bin/bash

# Check if Nginx is running
if ! pgrep -x "nginx" > /dev/null; then
    #echo "Nginx is not running"
    echo 0
    exit 1
fi

# Get the Nginx master process start time
start_time=$(ps -eo pid,lstart,cmd | grep 'nginx: master process' | grep -v grep | awk '{print $2, $3, $4, $5, $6}')

# Check if we successfully got the start time
if [ -z "$start_time" ]; then
    #echo "Failed to retrieve Nginx start time"
    echo 0
    exit 1
fi

# Convert start time to seconds since epoch
start_epoch=$(date -d "$start_time" +%s 2>/dev/null)

# Check if the date conversion was successful
if [ $? -ne 0 ]; then
    #echo "Date conversion failed"
    echo 0
    exit 1
fi

# Get the current time in seconds since epoch
current_epoch=$(date +%s)

# Calculate the uptime in seconds
uptime_seconds=$((current_epoch - start_epoch))

echo $uptime_seconds
