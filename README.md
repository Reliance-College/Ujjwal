# Cyber Dash Terminal Monitor

> A retro-futuristic, lightweight terminal dashboard and greeting script written in pure Bash. Featuring smooth typewriter ASCII banners, color-coded status metrics, and sleek visual resource gauges.

---

## Preview & Overview

When launched, **Cyber Dash** clears the screen and renders a retro-futuristic ASCII banner with a custom typewriter animation effect, followed by instant system diagnostics:

```
 ____  _   _ ____  _____ _____   ____    _    ____  _   _
/ ___|| | | |  _ \| ____|  _  | |  _ \  / \  / ___|| | | |
\___ \| | | | |_) |  _| | |_) | | | | |/ _ \ \___ \| |_| |
 ___) | |_| |  __/| |___|  _ <  | |_| / ___ \ ___) |  _  |
|____/ \___/|_|   |_____|_| \_\ |____/_/   \_\____/|_| |_|
 

  [ SYSTEM DIAGNOSTICS INITIALIZED ... ]
--------------------------------------------------------
SYSTEM METRICS:
  Host         : user@cyber-workstation
  OS Kernel    : Linux 6.5.0-x86_64
  Uptime       : 4 hours, 12 minutes
  Load Avg     : 0.42, 0.38, 0.25
  Memory       : 4120 MB / 16384 MB (25%)
  Disk (/)     : 48% space used
--------------------------------------------------------

VISUAL READOUT:
  RAM      [███████░░░░░░░░░░░░░░░░░░░░░] 25%
  DISK     [██████████████░░░░░░░░░░░░░░] 48%

>> System check complete. Have a productive session.
```

---

## Features

- **⚡ Lightweight & Fast**: Instant execution with zero bloat or heavy dependencies.
- ** Dynamic Color Coding**: Resource indicators change dynamically based on usage thresholds:
  -  **Green**: Under 60% (Optimal)
  -  **Yellow**: 60% – 85% (Moderate)
  -  **Red**: Over 85% (High / Critical)
- ** Typewriter Banner Animation**: Customizable character delay for retro cyberpunk terminal startup.
- ** Visual Gauge Bars**: Custom ASCII progress bars for RAM and primary disk partition.
- ** Zero External Dependencies**: Built entirely with native POSIX/Linux standard CLI utilities (`awk`, `df`, `free`, `uptime`).

---

##  Repository Structure

```
.
├── yettiho.sh     # Main Bash dashboard script
└── README.md         # Project documentation
```

---

## Quick Start

### 1. Make the script executable
```bash
chmod +x yettiho.sh
```

### 2. Run the script manually
```bash
./yettiho.sh
```

---

## Automatic Terminal Startup

Make **Cyber Dash** display every time you open a new terminal window or SSH session by adding it to your shell configuration file.

### For Bash (`~/.bashrc`)
```bash
echo "$PWD/yettiho.sh" >> ~/.bashrc
source ~/.bashrc
```

### For Zsh (`~/.zshrc`)
```bash
echo "$PWD/yettiho.sh" >> ~/.zshrc
source ~/.zshrc
```

---

## Customization Guide

### Changing the Banner ASCII Art
Open `yettiho.sh` and locate the `# --- Cyberpunk Banner Animation ---` block. You can replace the text inside `typewrite` calls with your own ASCII art (generated using tools like `figlet` or online ASCII generators):

```bash
echo -e "${CYAN}${BOLD}"
typewrite " YOUR ASCII BANNER HERE " 0.005
echo -e "${RESET}"
```

### ⚡ Adjusting Typewriter Speed
The `typewrite` function accepts an optional second parameter controlling delay in seconds per character:
- Fast: `typewrite "Text..." 0.005`
- Moderate: `typewrite "Text..." 0.02`
- Slow: `typewrite "Text..." 0.05`

### Modifying Usage Thresholds
To adjust when colors shift from Green to Yellow or Red, edit the values in the `get_status_color` helper function inside `yettiho.sh`:

```bash
get_status_color() {
    local value=$1
    if [ "$value" -gt 85 ]; then      # Red threshold (>85%)
        echo -e "${RED}"
    elif [ "$value" -gt 60 ]; then    # Yellow threshold (>60%)
        echo -e "${YELLOW}"
    else
        echo -e "${GREEN}"             # Green threshold (<=60%)
    fi
}
```

---

##  System Requirements & Compatibility

- **OS**: Linux / GNU environment (Ubuntu, Debian, Fedora, Arch, Alpine, WSL).
- **Shell**: Bash 4.0+.
- **Standard Utilities**: `awk`, `df`, `free`, `uptime`, `sed`, `xargs`.

> *Note for macOS users:* macOS uses BSD tools by default. For RAM stats to display on macOS, install `procps` via Homebrew (`brew install procps`) or adjust the `free` command in the script.

---

## 📜 License

This project is open-source and free to use, modify, and distribute under the MIT License.   
