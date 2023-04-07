local M = {}

M.disabled = {
  n = {
    ["<C-h>"] = "",
    ["<C-l>"] = "",
    ["<C-j>"] = "",
    ["<C-k>"] = "",
  },
}

M.general = {
	n = {
		[";"] = { ":", "command mode", opts = { nowait = true } },
	},

	i = {
		["jk"] = { "<ESC>", "escape insert mode" },
	},
}

M.treesitter = {
	n = {
		["<leader>cu"] = { "<cmd> TSCaptureUnderCursor <CR>", "find media" },
	},
}

M.nvterm = {
	n = {
		["<leader>gc"] = {
			function()
				require("nvterm.terminal").send("clear && g++ -o out " .. vim.fn.expand("%") .. " && ./out", "vertical")
			end,

			"compile & run a cpp file",
		},
	},
}

M.navigation = {
	n = {
		["H"] = { "^", "beginning of line" },
		["L"] = { "$", "end of line" },
	},
}

M.navigator = {
  n = {

    ["<C-h>"] = { "<cmd> NavigatorLeft <CR>", "navigate left" },
    ["<C-j>"] = { "<cmd> NavigatorDown <CR>", "navigate down" },
    ["<C-k>"] = { "<cmd> NavigatorUp <CR>", "navigate up" },
    ["<C-l>"] = { "<cmd> NavigatorRight <CR>", "navigate right" },
  },
  t = {
    ["<C-h>"] = { "<cmd> NavigatorLeft <CR>", "navigate left" },
    ["<C-j>"] = { "<cmd> NavigatorDown <CR>", "navigate down" },
    ["<C-k>"] = { "<cmd> NavigatorUp <CR>", "navigate up" },
    ["<C-l>"] = { "<cmd> NavigatorRight <CR>", "navigate right" },
  },
}

return M
