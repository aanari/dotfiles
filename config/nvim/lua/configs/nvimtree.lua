return {
  actions = {
    open_file = {
      resize_window = true,
    },
  },
  filters = {
    dotfiles = false,
    custom = { "node_modules", "env", "venv" },
  },
  view = {
    adaptive_size = true,
  },
  git = {
    enable = true,
  },
  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}
