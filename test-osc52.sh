#!/bin/bash
# Test OSC52 clipboard functionality

echo "Testing OSC52 clipboard functionality..."
echo "This script will attempt to copy text to your clipboard using OSC52"
echo

# Test string
TEST_STRING="OSC52 clipboard test $(date +%s)"
echo "Test string: $TEST_STRING"
echo

# Function to send OSC52 sequence
send_osc52() {
    local text="$1"
    local encoded=$(echo -n "$text" | base64 -w0)
    
    if [[ -n "$TMUX" ]]; then
        echo "Detected tmux environment"
        # Use Ptmux escape sequence for tmux
        printf '\033Ptmux;\033\033]52;c;%s\a\033\\' "$encoded"
    elif [[ "$TERM" == "screen"* ]]; then
        echo "Detected screen terminal"
        # Use DCS escape sequence for screen
        printf '\033P\033]52;c;%s\007\033\\' "$encoded"
    else
        echo "Direct terminal environment"
        # Use regular OSC52
        printf '\033]52;c;%s\a' "$encoded"
    fi
}

# Send the test string to clipboard
echo "Sending to clipboard via OSC52..."
send_osc52 "$TEST_STRING"

echo
echo "✓ OSC52 sequence sent!"
echo
echo "To verify it worked:"
echo "1. Try pasting (Cmd+V or Ctrl+V) - you should see: $TEST_STRING"
echo "2. On macOS, run: pbpaste"
echo "3. On Linux with xclip: xclip -o -selection clipboard"
echo
echo "Environment info:"
echo "  TERM=$TERM"
echo "  TMUX=$TMUX"
echo "  SSH_TTY=$SSH_TTY"
echo "  SSH_CONNECTION=$SSH_CONNECTION"