# Server Stats Script

This is a Bash script (`server-stats.sh`) that displays basic server performance statistics including CPU usage, memory usage, disk usage, top processes, and more.

## ✅ Features

- Total CPU usage
- Total memory usage (used vs free)
- Total disk usage (used vs free)
- Top 5 processes by CPU and memory
- OS version, uptime, load average
- Failed login attempts

## 🚀 How to Run

1. Download the script:
   ```bash
   curl -O https://github.com/MDinesh09/Devops-Roadmap-Projects.git
   ```
2. Make it executable:
   ```bash
   chmod +x server-stats.sh
   ```
3. Run it:
   ```bash
   ./server-stats.sh
   ```

## Sample Output

### The script returns a report like:

### Top 5 Processes by CPU

| PID   | COMMAND       | %CPU  |
|-------|---------------|-------|
| 1204  | chrome        | 45.3  |
| 2345  | java          | 20.0  |
| 1987  | firefox       | 9.8   |
| 2567  | code          | 6.5   |
| 2890  | gnome-shell   | 5.3   |

### Failed Login Attempts

**Failed login attempts:** 4


# Reference

    https://roadmap.sh/projects/server-stats
