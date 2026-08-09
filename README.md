# System Information Utility

A Bash utility that displays useful system information such as hostname,
operating system, kernel version, uptime, CPU, memory, and disk usage.

## Features

- Displays hostname
- Displays operating system
- Displays kernel version
- Displays system uptime
- Displays CPU model
- Displays total memory
- Displays root filesystem disk usage
- Supports `-h` / `--help`
- Supports `-v` / `--version`
- Handles invalid arguments
- Uses exit codes for success and failure

## What I Learned

- Bash functions
- Positional parameters
- Command substitution
- Exit statuses
- `case` statements
- `if/else` conditions
- Pipeline handling with `pipefail`
- stdout and stderr

## Usage

Run normally:

`./system-info.sh`

Display help:

`./system-info.sh --help`

Display version:

`./system-info.sh --version`
