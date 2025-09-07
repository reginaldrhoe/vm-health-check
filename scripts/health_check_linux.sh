#!/bin/bash

# Function to check CPU usage
check_cpu() {
    cpu_usage=$(top -bn1 | grep 'Cpu(s)' | awk '{print $2 + $4}')
    if (( $(echo "$cpu_usage > 85" | bc -l) )); then
        echo -e "\e[31mX High CPU usage: $cpu_usage%\e[0m"
    else
        echo -e "\e[32m√ CPU usage: $cpu_usage%\e[0m"
    fi
}

# Function to check memory usage
check_memory() {
    mem_usage=$(free | awk '/Mem/ { printf("%.2f", $3/$2 * 100.0) }')
    if (( $(echo "$mem_usage > 90" | bc -l) )); then
        echo -e "\e[31mX High memory usage: $mem_usage%\e[0m"
    else
        echo -e "\e[32m√ Memory usage: $mem_usage%\e[0m"
    fi
}

# Function to check disk usage
check_disk() {
    disk_usage=$(df / | awk 'END { print $5 }' | sed 's/%//')
    if (( disk_usage > 80 )); then
        echo -e "\e[31mX High disk usage: $disk_usage%\e[0m"
    else
        echo -e "\e[32m√ Disk usage: $disk_usage%\e[0m"
    fi
}

# Function to explain the health status
explain() {
    echo "This script checks the health status of your VM by monitoring CPU, memory, and disk usage."
    echo "CPU usage above 85% is considered high and may affect performance."
    echo "Memory usage above 90% indicates memory pressure and may lead to performance issues."
    echo "Disk usage above 80% is considered high and may affect system stability."
}

# Main function
main() {
    while true; do
        clear
        check_cpu
        check_memory
        check_disk
        sleep 5
    done
}

# Argument parsing
case "$1" in
    --explain)
        explain
        ;;
    *)
        main
        ;;
esac
