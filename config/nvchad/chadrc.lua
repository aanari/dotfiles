---@type ChadrcConfig
local M = {}

M.plugins = "custom.plugins" -- path for lazy.nvim

M.ui = {
	theme = "nord",
	hl_override = {
		Comment = { italic = true },
	},
	-- transparency = true,

	-- tabufline = {
	--   show_numbers = true
	-- }
}

M.mappings = require("custom.mappings")

return M
