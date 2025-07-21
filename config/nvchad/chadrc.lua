---@type ChadrcConfig
local M = {}

M.plugins = "custom.plugins" -- path for lazy.nvim

M.ui = {
	theme = "yoru",
	transparency = true,
	hl_override = require("custom.highlights").override,
	hl_add = require("custom.highlights").add,
}

M.mappings = require("custom.mappings")

local icons = {
	[vim.diagnostic.severity.ERROR] = "'",
	[vim.diagnostic.severity.WARN] = "󰀦",
	[vim.diagnostic.severity.INFO] = "󰌶",
	[vim.diagnostic.severity.HINT] = "󱞩",
}

vim.diagnostic.config({
	signs = {
		text = icons,
	},
})

return M
