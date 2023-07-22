require("custom.commands")
require("custom.autocmds")

vim.opt.title = true

vim.g.virtcolumn_char = "┊"
vim.opt.colorcolumn = "80,120"

vim.cmd([[
  set clipboard+=unnamedplus
]])

if vim.fn.has("wsl") == 1 then
	vim.api.nvim_create_autocmd("TextYankPost", {

		group = vim.api.nvim_create_augroup("Yank", { clear = true }),

		callback = function()
			vim.fn.system("clip.exe", vim.fn.getreg('"'))
		end,
	})
end

local function copy(lines, _)
	require("osc52").copy(table.concat(lines, "\n"))
end

local function paste()
	return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
end

vim.opt.guifont = { "PragmataProMonoLiga Nerd Font", "h13" }

vim.g.clipboard = {
	name = "osc52",
	copy = { ["+"] = copy, ["*"] = copy },
	paste = { ["+"] = paste, ["*"] = paste },
}

-- Now the '+' register will copy to system clipboard using OSC52
vim.keymap.set("n", "<leader>c", '"+y')
vim.keymap.set("n", "<leader>cc", '"+yy')

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
