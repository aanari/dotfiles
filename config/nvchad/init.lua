require("custom.commands")
require("custom.autocmds")

vim.opt.title = true

vim.cmd([[
  set clipboard+=unnamedplus
]])

local function copy(lines, _)
	require("osc52").copy(table.concat(lines, "\n"))
end

local function paste()
	return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
end

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

vim.opt.cursorline = true
vim.opt.cursorcolumn = false
