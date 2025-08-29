cpu_usage() {
        echo "CPU Usage:"
        echo "-------------------------------------"
        mpstat | grep "all" | awk '{printf " User: %.2f% System: %.2f% Idle: %.2f%\n", $4, $6, $13}'
        echo ""
}

cpu_usage

echo "Memory Usage:"
echo "-------------------------------------"
free -h | awk 'NR==2{printf " Used: %s Free: %s Usage:%.2f%% All memory: %s\n", $3, $4, ($2/$3*100), $2}' 
echo ""

echo "Disk Usage:"
echo "-------------------------------------"
df -h | grep "^/dev/" | awk '{printf "%s Total: %s Used: %s Available: %s Usage: %s\n", $1, $2, $3, $4, $5}'
echo ""

echo "Top 5 processes by CPU usage:" 
echo "-------------------------------------"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo ""

echo "Top 5 processes by Memory usage:"
echo "-------------------------------------"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo ""

echo "OS version:"
cat /etc/os-release
echo ""

echo "Uptime:"
uptime
echo ""

echo "Load Average:"
uptime | awk '{print " Load Average: ", $9}'
echo ""

echo "Logged-in Users:"
who
echo ""

echo "Failed Login Attempts:"
journalctl -xe | grep "Failed password" 
echo ""
