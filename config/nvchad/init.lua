require("custom.commands")
require("custom.autocmds")

vim.opt.title = true

vim.g.virtcolumn_char = "┊"
vim.opt.colorcolumn = "80,120"

vim.opt.guifont = { "PragmataProMonoLiga Nerd Font", "h13" }

vim.api.nvim_set_hl(0, "TSRainbowRed", { fg = "#be6069" })
vim.api.nvim_set_hl(0, "TSRainbowYellow", { fg = "#ebca8a" })
vim.api.nvim_set_hl(0, "TSRainbowBlue", { fg = "#81a0c0" })
vim.api.nvim_set_hl(0, "TSRainbowOrange", { fg = "#b48dac" })
vim.api.nvim_set_hl(0, "TSRainbowGreen", { fg = "#a3bd8b" })
vim.api.nvim_set_hl(0, "TSRainbowViolet", { fg = "#88bfcf" })
vim.api.nvim_set_hl(0, "TSRainbowCyan", { fg = "#e5e8ef" })
vim.api.nvim_set_hl(0, "HlSearchNear", { fg = "#2E3440", bg = "#EBCB8B" })
vim.api.nvim_set_hl(0, "HlSearchLens", { fg = "#2E3440", bg = "#88bfcf" })
vim.api.nvim_set_hl(0, "HlSearchLensNear", { fg = "#2E3440", bg = "#EBCB8B" })

vim.opt.cursorline = true
vim.opt.cursorcolumn = false

local kopts = { noremap = true, silent = true }

vim.api.nvim_set_keymap(
	"n",
	"n",
	[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
	kopts
)
vim.api.nvim_set_keymap(
	"n",
	"N",
	[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
	kopts
)
vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap("n", "<Leader>l", "<Cmd>noh<CR>", kopts)

vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })

-- Clipboard yanker
local status_ok, osc52 = pcall(require, "osc52")
if not status_ok then
  return
end

osc52.setup {
  max_length = 0, -- Maximum length of selection (0 for no limit)
  silent = false, -- Disable message on successful copy
  trim = false, -- Trim text before copy
}

vim.keymap.set("n", "<leader>y", osc52.copy_operator, { expr = true })
vim.keymap.set("n", "<leader>yy", "<leader>y_", { remap = true })
vim.keymap.set("x", "<leader>y", osc52.copy_visual)
