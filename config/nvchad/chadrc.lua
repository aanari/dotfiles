---@type ChadrcConfig
local M = {}

M.plugins = "custom.plugins" -- path for lazy.nvim

M.ui = {
	theme = "yoru",
	hl_override = require("custom.highlights").override,
	hl_add = require("custom.highlights").add,
}

M.mappings = require("custom.mappings")

return M
