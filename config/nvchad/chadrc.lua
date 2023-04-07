---@type ChadrcConfig
local M = {}

M.plugins = "custom.plugins" -- path for lazy.nvim

M.ui = {
	theme = "nord",
	hl_override = require("custom.highlights"),
	hl_add = {},
}

M.mappings = require("custom.mappings")

return M
