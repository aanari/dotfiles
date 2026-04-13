local M = {}

M.override = {
  Include = { italic = true },
  ["@include"] = { italic = true },

  Comment = { italic = true },
  SpecialComment = { link = "Comment" },
  ["@comment"] = { link = "Comment" },

  Conditional = { italic = true },
  ["@conditional"] = { link = "Conditional" },

  Function = { italic = true, bold = true },
  ["@function"] = { link = "Function" },
  ["@method"] = { bold = true },

  Type = { italic = true },
  ["@type"] = { link = "Type" },
  ["@error"] = { undercurl = true },

  CursorLine = { bg = "none" },
  CursorReset = { fg = "#ffffff", bg = "#ffffff" },
  Visual = { bg = "#E5EBF1" },

  NvimTreeCursorLine = { bg = "#eef0f1", bold = true },
  NvimTreeOpenedFolderName = { bold = true, italic = true },
  NvimTreeOpenedFile = { bold = true, italic = true },

  TelescopeSelection = { bg = "#eef0f1", bold = true },

  DiagnosticUnderlineError = { undercurl = true },
  DiagnosticUnderlineWarn = { undercurl = true },
  DiagnosticUnderlineInfo = { underdashed = true },
  DiagnosticUnderlineHint = { underdashed = true },

  IlluminatedWordText = { bg = "#22282a" },
  IlluminatedWordRead = { bg = "#22282a" },
  IlluminatedWordWrite = { bg = "#22282a" },
}

M.add = {
  MsgArea = { fg = "#5C91CE", bold = true },
  HighlightYank = { bg = "#ffff99" },
  HlSearchNear = { fg = "#0c0e0f", bg = "#f6dc95" },

  RainbowDelimiterRed = { fg = "#e8646a" },
  RainbowDelimiterYellow = { fg = "#ecd28b" },
  RainbowDelimiterBlue = { fg = "#709ad2" },
  RainbowDelimiterOrange = { fg = "#E89982" },
  RainbowDelimiterGreen = { fg = "#81c19b" },
  RainbowDelimiterViolet = { fg = "#c58cec" },
  RainbowDelimiterCyan = { fg = "#67AFC1" },
}

return M
