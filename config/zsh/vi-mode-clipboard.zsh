# OSC52 clipboard integration for zsh-vi-mode
# This ensures yanking in vi-mode uses OSC52 to sync with system clipboard

# Custom yank function that uses OSC52 directly
zvm_vi_yank() {
  zvm_yank
  # Get the yanked text from the ZLE kill buffer and send via OSC52
  if [[ -n "$TMUX" ]]; then
    # Inside tmux, use Ptmux escape sequence
    printf "$CUTBUFFER" | base64 -w0 | xargs -I{} printf '\033Ptmux;\033\033]52;c;{}\a\033\\' >/dev/tty
  else
    # Outside tmux, use regular OSC52
    printf "$CUTBUFFER" | base64 -w0 | xargs -I{} printf '\033]52;c;{}\a' >/dev/tty
  fi
}

# Override the default yank widgets to use our custom function
zvm_after_lazy_keybindings() {
  # Visual mode yanks
  zvm_define_widget zvm_vi_yank
  zvm_bindkey visual 'y' zvm_vi_yank
  
  # Normal mode yanks
  zvm_bindkey vicmd 'yy' zvm_vi_yank
  zvm_bindkey vicmd 'Y' zvm_vi_yank
  
  # Yank to end of line
  zvm_bindkey vicmd 'y$' zvm_vi_yank
  zvm_bindkey vicmd 'y^' zvm_vi_yank
  zvm_bindkey vicmd 'y0' zvm_vi_yank
  
  # Yank with motion
  zvm_bindkey vicmd 'yw' zvm_vi_yank
  zvm_bindkey vicmd 'yW' zvm_vi_yank
  zvm_bindkey vicmd 'yb' zvm_vi_yank
  zvm_bindkey vicmd 'yB' zvm_vi_yank
  zvm_bindkey vicmd 'ye' zvm_vi_yank
  zvm_bindkey vicmd 'yE' zvm_vi_yank
}

# Paste from clipboard using OSC52 (optional - if your terminal supports OSC52 paste)
# Most terminals don't support reading from clipboard via OSC52 for security reasons
# So we'll keep the default paste behavior