---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "one_light",
  transparency = true,
  hl_override = require("highlights").override,
  hl_add = require("highlights").add,
  integrations = {},
}

M.ui = {
  tabufline = {
    enabled = true,
  },
}

return M
