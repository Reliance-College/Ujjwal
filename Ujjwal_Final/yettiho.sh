#!/usr/bin/env bash

# --- Color Definitions ---
BOLD="\033[1m"
CYAN="\033[36m"
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
BLUE="\033[34m"
RESET="\033[0m"

# --- Typewriter Animation Function ---
typewrite() {
    local text="$1"
    local delay="${2:-0.02}"
    for (( i=0; i<${#text}; i++ )); do
        echo -n "${text:$i:1}"
        sleep "$delay"
    done
    echo ""
}

clear

# --- Cyberpunk Banner Animation ---
echo -e "${CYAN}${BOLD}"
typewrite "  ____  _   _ ____  _____ _____   ____    _    ____  _   _ " 0.005
typewrite " / ___|| | | |  _ \| ____|  _  | |  _ \  / \  / ___|| | | |" 0.005
typewrite " \___ \| | | | |_) |  _| | |_) | | | | |/ _ \ \___ \| |_| |" 0.005
typewrite "  ___) | |_| |  __/| |___|  _ <  | |_| / ___ \ ___) |  _  |" 0.005
typewrite " |____/ \___/|_|   |_____|_| \_\ |____/_/   \_\____/|_| |_|" 0.005
echo -e "${RESET}"

typewrite "  [ SYSTEM DIAGNOSTICS INITIALIZED ... ]" 0.03
echo "--------------------------------------------------------"
sleep 0.2

# --- Data Gathering ---
HOSTNAME=$(hostname)
USER_NAME=$(whoami)
UPTIME=$(uptime -p | sed 's/up //')
OS=$(uname -s -r -m)

# RAM calculation
MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
MEM_PCT=$(( MEM_USED * 100 / MEM_TOTAL ))

# Disk calculation (root /)
DISK_PCT=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')

# Load average
LOAD=$(uptime | awk -F'load average:' '{ print $2 }' | xargs)

# --- Dynamic Color Helper ---
get_status_color() {
    local value=$1
    if [ "$value" -gt 85 ]; then
        echo -e "${RED}"
    elif [ "$value" -gt 60 ]; then
        echo -e "${YELLOW}"
    else
        echo -e "${GREEN}"
    fi
}

# --- Output System Stats ---
echo -e "${BOLD}SYSTEM METRICS:${RESET}"
printf "  %-12s : %s\n" "Host" "$USER_NAME@$HOSTNAME"
printf "  %-12s : %s\n" "OS Kernel" "$OS"
printf "  %-12s : %s\n" "Uptime" "$UPTIME"
printf "  %-12s : %s\n" "Load Avg" "$LOAD"

RAM_COLOR=$(get_status_color "$MEM_PCT")
printf "  %-12s : ${RAM_COLOR}%d MB / %d MB (%d%%)${RESET}\n" "Memory" "$MEM_USED" "$MEM_TOTAL" "$MEM_PCT"

DISK_COLOR=$(get_status_color "$DISK_PCT")
printf "  %-12s : ${DISK_COLOR}%d%% space used${RESET}\n" "Disk (/)" "$DISK_PCT"

echo "--------------------------------------------------------"

# --- Progress Bar Visualizer ---
draw_bar() {
    local label=$1
    local pct=$2
    local color=$3
    local bar_len=30
    local filled=$(( pct * bar_len / 100 ))
    local empty=$(( bar_len - filled ))

    printf "  %-8s [" "$label"
    printf "${color}"
    for ((i=0; i<filled; i++)); do printf "█"; done
    for ((i=0; i<empty; i++)); do printf "░"; done
    printf "${RESET}] %d%%\n" "$pct"
}

echo -e "\n${BOLD}VISUAL READOUT:${RESET}"
draw_bar "RAM" "$MEM_PCT" "$RAM_COLOR"
draw_bar "DISK" "$DISK_PCT" "$DISK_COLOR"

echo ""
typewrite "${CYAN}>> System check complete. Have a productive session.${RESET}" 0.02
echo ""
