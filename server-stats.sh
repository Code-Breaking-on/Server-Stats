#!/bin/bash

# Colors for presentation
GREEN="\e[32m"
BLUE="\e[34m"
CYAN="\e[36m"
YELLOW="\e[33m"
RED="\e[31m"
BOLD="\e[1m"
RESET="\e[0m"

# Line separator
separator() {
    echo -e "${BLUE}------------------------------------------------------------${RESET}"
}

# Header
header() {
    echo -e "${BOLD}${CYAN}\nSERVER PERFORMANCE STATS${RESET}"
    separator
}

# Section title
section() {
    echo -e "\n${BOLD}${YELLOW}$1${RESET}"
}

# OS Version
get_os_version() {
    section "Operating System"
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo -e "${GREEN}$PRETTY_NAME${RESET}"
    else
        uname -a
    fi
}

# Uptime
get_uptime() {
    section "Uptime"
    uptime -p
}

# Load Average
get_load_avg() {
    section "Load Average (1, 5, 15 min)"
    uptime | awk -F'load average:' '{ print $2 }'
}

# Logged in users
get_logged_users() {
    section "Logged-in Users"
    who | wc -l
}

# CPU Usage
get_cpu_usage() {
    section "CPU Usage"
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
    echo -e "Total CPU Usage: ${RED}${CPU_USAGE}%${RESET}"
}

# Memory Usage
get_memory_usage() {
    section "Memory Usage (MB)"
    free -m | awk 'NR==2{
        total=$2; used=$3; free=$4;
        printf "%-10s %-10s %-10s %-10s\n", "Total", "Used", "Free", "Usage %";
        printf "%-10s %-10s %-10s %-10.2f%%\n", total, used, free, used/total*100
    }'
}

# Disk Usage
get_disk_usage() {
    section "Disk Usage (Root Partition)"
    df -h / | awk 'NR==2{
        printf "%-10s %-10s %-12s %-10s\n", "Total", "Used", "Available", "Usage";
        printf "%-10s %-10s %-12s %-10s\n", $2, $3, $4, $5
    }'
}

# Top processes by CPU
get_top_cpu_processes() {
    section "Top 5 Processes by CPU"
    printf "%-8s %-20s %-10s\n" "PID" "COMMAND" "%CPU"
    ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6 | tail -n 5 | awk '{printf "%-8s %-20s %-10s\n", $1, $2, $3}'
}

# Top processes by Memory
get_top_mem_processes() {
    section "Top 5 Processes by Memory"
    printf "%-8s %-20s %-10s\n" "PID" "COMMAND" "%MEM"
    ps -eo pid,comm,%mem --sort=-%mem | head -n 6 | tail -n 5 | awk '{printf "%-8s %-20s %-10s\n", $1, $2, $3}'
}

# Failed login attempts
get_failed_logins() {
    section "Failed Login Attempts"
    if [ -f /var/log/auth.log ]; then
        COUNT=$(grep -i "failed password" /var/log/auth.log | wc -l)
        echo "Failed login attempts: $COUNT"
    elif [ -f /var/log/secure ]; then
        COUNT=$(grep -i "failed password" /var/log/secure | wc -l)
        echo "Failed login attempts: $COUNT"
    else
        echo "Log file not found or permission denied"
    fi
}

# Footer
footer() {
    separator
    echo -e "${CYAN}${BOLD}Report complete.${RESET}\n"
}

# Run all
header
get_os_version
get_uptime
get_load_avg
get_logged_users
get_cpu_usage
get_memory_usage
get_disk_usage
get_top_cpu_processes
get_top_mem_processes
get_failed_logins
footer
