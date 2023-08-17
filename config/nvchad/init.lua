require("custom.commands")
require("custom.autocmds")

vim.o.mouse = "a"
vim.o.clipboard = "unnamedplus"
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
vim.opt.guifont = { "PragmataProMonoLiga Nerd Font", "h13" }

vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#e8646a" })
vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#ecd28b" })
vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#709ad2" })
vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#E89982" })
vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#81c19b" })
vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#c58cec" })
vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#67AFC1" })

vim.api.nvim_set_hl(0, "HlSearchNear", { fg = "#0c0e0f", bg = "#f6dc95" })

vim.opt.signcolumn = "number"
vim.opt.cursorline = true
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

-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "IlluminatedWordText", timeout = 150 })
	end,
	group = highlight_group,
	pattern = "*",
})

-- Clipboard yanker
local status_ok, osc52 = pcall(require, "osc52")
if not status_ok then
	return
end

osc52.setup({
	max_length = 0, -- Maximum length of selection (0 for no limit)
	silent = false, -- Disable message on successful copy
	trim = false, -- Trim text before copy
})

-- TODO: Clean up these key mappings
-- Yanking
vim.keymap.set("n", "<leader>y", osc52.copy_operator, { expr = true })
vim.keymap.set("n", "<leader>yy", "<leader>y_", { remap = true })
vim.keymap.set("x", "<leader>y", osc52.copy_visual)
-- Hopping
vim.keymap.set("n", "S", "<cmd>lua require'hop'.hint_char2()<cr>", {})
vim.keymap.set("n", "s", "<cmd>lua require'hop'.hint_patterns({}, vim.fn['getreg']('/'))<cr>", {})
