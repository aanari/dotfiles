require "nvchad.autocmds"
require "commands"

local autocmd = vim.api.nvim_create_autocmd

autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

-- Flash what was just yanked, so the extent of a motion is visible. Borrow
-- Visual rather than name a color, so it follows whatever base46 theme is
-- loaded. Swap in Search or IncSearch if the wash is too quiet to catch.
autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

-- Treesitter indentation (nvim-treesitter `main` branch no longer wires this
-- up automatically; opt in once per buffer when a parser is attached).
-- Highlighting is handled by NvChad's `vim.treesitter.start` FileType autocmd.
autocmd("FileType", {
  pattern = "*",
  callback = function(args)
    local bufnr = args.buf
    if not vim.treesitter.language.get_lang(vim.bo[bufnr].filetype) then
      return
    end
    pcall(function()
      vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end)
  end,
})
