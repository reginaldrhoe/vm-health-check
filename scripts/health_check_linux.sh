#!/bin/bash

# Function to check CPU usage
check_cpu() {
    cpu_usage=$(top -bn1 | grep 'Cpu(s)' | awk '{print $2 + $4}')
    echo "CPU Usage: $cpu_usage%"
}

# Function to check memory usage
check_memory() {
    mem_usage=$(free | awk '/Mem/ { printf("%.2f", $3/$2 * 100.0) }')
    echo "Memory Usage: $mem_usage%"
}

# Function to check disk usage
check_disk() {
    disk_usage=$(df / | awk 'END { print $5 }' | sed 's/%//')
    echo "Disk Usage: $disk_usage%"
}

# Main function
main() {
    check_cpu
    check_memory
    check_disk
}

# Entry point
main "$@"