local M = {}

M.override = {
	Include = { italic = true },
	["@include"] = { italic = true },

	["@method"] = { bold = true },
	["@error"] = { undercurl = true },

	Comment = { italic = true },
	SpecialComment = { link = "Comment" },
	["@comment"] = { link = "Comment" },

	Conditional = { italic = true },
	["@conditional"] = { link = "Conditional" },

	Function = { italic = true, bold = true },
	["@function"] = { link = "Function" },

	Type = { italic = true },
	["@type"] = { link = "Type" },

	CursorLine = { bg = "#22272a" },
	CursorReset = { fg = "#ffffff", bg = "#ffffff" },
	Visual = { fg = "#0c0e0f", bg = "#bac1c5" },

	NvimTreeCursorLine = { bg = "#22272a", bold = true },
	NvimTreeOpenedFolderName = { bold = true, italic = true },
	NvimTreeOpenedFile = { bold = true, italic = true },

	TelescopeSelection = { bg = "#22272a", bold = true },

	TSComment = { italic = true },
	TSConditional = { italic = true },
	TSAttribute = { italic = true },
	TSMethod = { italic = true },
	TSParameter = { italic = true },
	TSKeywordOperator = { italic = true },
	TSLabel = { italic = true },
	TSVariableBuiltin = { italic = true },
	TSTagAttribute = { italic = true },
	TSStrong = { bold = true, italic = true },
	TSEmphasis = { bold = true, italic = true },
	TSFunction = { bold = true, italic = true },
	TSUnderline = { underline = true, style = "underline" },
	TSURI = { underline = true, style = "underline" },
	TSInclude = { bold = true, italic = true },
	TSConstructor = { bold = true },
	TSKeywordFunction = { bold = true, italic = true },
	TSRepeat = { italic = true, bold = true },
}

M.add = {
	MsgArea = { fg = "#5C91CE", bold = true },
}

return M
