#!/bin/bash
# Debug OSC52 clipboard issues

echo "=== OSC52 Clipboard Debug Tool ==="
echo

# Check terminal capabilities
check_terminal() {
    echo "Terminal Information:"
    echo "  TERM: $TERM"
    echo "  TERM_PROGRAM: $TERM_PROGRAM"
    echo "  TERMINAL_EMULATOR: $TERMINAL_EMULATOR"
    echo
    
    # Check for OSC52 support in terminfo
    echo "Checking terminfo capabilities:"
    if infocmp -1 2>/dev/null | grep -q Ms; then
        echo "  ✓ Ms capability found (OSC52 support indicated)"
        infocmp -1 | grep Ms
    else
        echo "  ✗ Ms capability not found in terminfo"
    fi
    echo
}

# Check tmux configuration
check_tmux() {
    echo "Tmux Information:"
    if [[ -n "$TMUX" ]]; then
        echo "  ✓ Running inside tmux"
        echo "  TMUX: $TMUX"
        echo
        echo "  Tmux clipboard settings:"
        tmux show-options -g | grep -E "set-clipboard|terminal-overrides|allow-passthrough" | sed 's/^/    /'
    else
        echo "  ✗ Not running inside tmux"
    fi
    echo
}

# Check SSH session
check_ssh() {
    echo "SSH Information:"
    if [[ -n "$SSH_TTY" ]] || [[ -n "$SSH_CONNECTION" ]]; then
        echo "  ✓ SSH session detected"
        echo "  SSH_TTY: $SSH_TTY"
        echo "  SSH_CONNECTION: $SSH_CONNECTION"
        echo "  SSH_CLIENT: $SSH_CLIENT"
    else
        echo "  ✗ Not an SSH session"
    fi
    echo
}

# Test OSC52 with different methods
test_osc52_methods() {
    echo "Testing OSC52 Methods:"
    echo "------------------------"
    
    TEST_TEXT="osc52-test-$(date +%s)"
    ENCODED=$(echo -n "$TEST_TEXT" | base64 -w0)
    
    echo "Test string: $TEST_TEXT"
    echo "Base64 encoded: $ENCODED"
    echo
    
    echo "1. Direct OSC52:"
    echo "   Command: printf '\\033]52;c;$ENCODED\\a'"
    printf '\033]52;c;%s\a' "$ENCODED"
    echo " [sent]"
    echo
    
    if [[ -n "$TMUX" ]]; then
        echo "2. Tmux Ptmux wrapper:"
        echo "   Command: printf '\\033Ptmux;\\033\\033]52;c;$ENCODED\\a\\033\\\\'"
        printf '\033Ptmux;\033\033]52;c;%s\a\033\\' "$ENCODED"
        echo " [sent]"
        echo
        
        echo "3. Tmux Ms capability:"
        echo "   Command: tmux set-buffer \"$TEST_TEXT\" && tmux save-buffer - | base64 -w0"
        tmux set-buffer "$TEST_TEXT" 2>/dev/null
        if tmux save-buffer - 2>/dev/null | base64 -w0 >/dev/null; then
            echo "   ✓ Tmux buffer operations working"
        else
            echo "   ✗ Tmux buffer operations failed"
        fi
        echo
    fi
    
    if [[ "$TERM" == "screen"* ]]; then
        echo "4. Screen DCS wrapper:"
        echo "   Command: printf '\\033P\\033]52;c;$ENCODED\\007\\033\\\\'"
        printf '\033P\033]52;c;%s\007\033\\' "$ENCODED"
        echo " [sent]"
        echo
    fi
}

# Check for clipboard tools
check_clipboard_tools() {
    echo "Clipboard Tools:"
    
    if command -v pbcopy >/dev/null 2>&1; then
        echo "  ✓ pbcopy/pbpaste available (macOS)"
    fi
    
    if command -v xclip >/dev/null 2>&1; then
        echo "  ✓ xclip available (Linux)"
    fi
    
    if command -v xsel >/dev/null 2>&1; then
        echo "  ✓ xsel available (Linux)"
    fi
    
    if command -v wl-copy >/dev/null 2>&1; then
        echo "  ✓ wl-copy available (Wayland)"
    fi
    
    if command -v clip >/dev/null 2>&1; then
        echo "  ✓ clip script available"
        echo "    Location: $(which clip)"
    fi
    
    if command -v yanker >/dev/null 2>&1; then
        echo "  ✓ yanker script available"
        echo "    Location: $(which yanker)"
    fi
    echo
}

# Main execution
main() {
    check_terminal
    check_tmux
    check_ssh
    check_clipboard_tools
    test_osc52_methods
    
    echo "=== Verification ==="
    echo "Try pasting now. You should see one of the test strings."
    echo "If clipboard doesn't work, check the configuration items marked with ✗"
    echo
    echo "Common fixes:"
    echo "1. In tmux.conf: set -s set-clipboard external"
    echo "2. In tmux.conf: set -ga terminal-overrides ',*:Ms=\\E]52;%p1%s;%p2%s\\007'"
    echo "3. Ensure terminal supports OSC52 (WezTerm, Alacritty, iTerm2, etc.)"
    echo "4. For SSH: ensure terminal on client side supports OSC52"
}

main "$@"