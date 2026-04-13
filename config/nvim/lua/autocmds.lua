require "nvchad.autocmds"
require "commands"

local autocmd = vim.api.nvim_create_autocmd

autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { higroup = "HighlightYank", timeout = 100 }
  end,
})
