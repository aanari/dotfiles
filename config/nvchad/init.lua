require("custom.commands")
require("custom.autocmds")

vim.o.mouse = "a"
vim.o.breakindent = true
vim.o.swapfile = false
vim.o.showmode = false
vim.opt.updatetime = 200
vim.opt.timeoutlen = 300
vim.opt.title = true
vim.opt.shortmess:append("A") -- Ignores swapfiles when opening file
vim.opt.shortmess:append("s") -- Disable 'Search hit BOTTOM, continuing at TOP'
vim.opt.shortmess:append("cS") -- Disable "[1/5]", "Pattern not found", etc.
vim.opt.shortmess:append("FW") -- Disable message after editing/writing file
vim.opt.guifont = { "PragmataProMonoLiga Nerd Font" }

vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#e8646a" })
vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#ecd28b" })
vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#709ad2" })
vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#E89982" })
vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#81c19b" })
vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#c58cec" })
vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#67AFC1" })

vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { underdashed = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { underdashed = true })

vim.api.nvim_set_hl(0, "HlSearchNear", { fg = "#0c0e0f", bg = "#f6dc95" })

vim.opt.cursorline = false
vim.opt.cursorcolumn = false
vim.opt.termguicolors = true
vim.opt.guicursor = {
	[[n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50]],
	[[a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor]],
	[[sm:block-blinkwait175-blinkoff150-blinkon175]],
}

vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#22282a" })
vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#22282a" })
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#22282a" })

-- Hopping
vim.keymap.set("n", "S", "<cmd>lua require'hop'.hint_char2()<cr>", {})
vim.keymap.set("n", "s", "<cmd>lua require'hop'.hint_patterns({}, vim.fn['getreg']('/'))<cr>", {})
