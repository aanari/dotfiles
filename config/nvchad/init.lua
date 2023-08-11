require("custom.commands")
require("custom.autocmds")

vim.opt.updatetime = 200
vim.opt.title = true
vim.o.swapfile = false
vim.opt.guifont = { "PragmataProMonoLiga Nerd Font", "h13" }

vim.api.nvim_set_hl(0, "TSRainbowRed", { fg = "#e8646a" })
vim.api.nvim_set_hl(0, "TSRainbowYellow", { fg = "#e79881" })
vim.api.nvim_set_hl(0, "TSRainbowBlue", { fg = "#709ad2" })
vim.api.nvim_set_hl(0, "TSRainbowOrange", { fg = "#c58cec" })
vim.api.nvim_set_hl(0, "TSRainbowGreen", { fg = "#81c19b" })
vim.api.nvim_set_hl(0, "TSRainbowViolet", { fg = "#70b8ca" })
vim.api.nvim_set_hl(0, "TSRainbowCyan", { fg = "#f2f4f5" })
vim.api.nvim_set_hl(0, "HlSearchNear", { fg = "#0c0e0f", bg = "#ECD28B" })
vim.api.nvim_set_hl(0, "HlSearchLens", { fg = "#0c0e0f", bg = "#e79881" })
vim.api.nvim_set_hl(0, "HlSearchLensNear", { fg = "#0c0e0f", bg = "#ECD28B" })

vim.opt.cursorline = true
vim.opt.cursorcolumn = false
vim.opt.termguicolors = true
vim.opt.guicursor = {
  [[n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50]],
  [[a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor]],
  [[sm:block-blinkwait175-blinkoff150-blinkon175]],
}

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

vim.keymap.set("n", "<leader>y", osc52.copy_operator, { expr = true })
vim.keymap.set("n", "<leader>yy", "<leader>y_", { remap = true })
vim.keymap.set("x", "<leader>y", osc52.copy_visual)
