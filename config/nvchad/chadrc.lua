---@type ChadrcConfig
local M = {}

M.plugins = "custom.plugins" -- path for lazy.nvim

M.ui = {
	theme = "yoru",
	hl_override = require("custom.highlights").override,
	hl_add = require("custom.highlights").add,
}

M.mappings = require("custom.mappings")

local function lspSymbol(name, icon)
	local hl = "DiagnosticSign" .. name
	vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

lspSymbol("Error", "\u{f146}")
lspSymbol("Warn", "\u{f14a}")
lspSymbol("Info", "\u{f14d}")
lspSymbol("Hint", "\u{f0fd}")

return M
