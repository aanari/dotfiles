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
		-- Keep cursor in the center line when C-D / C-U
		["<C-d>"] = { "<C-d>zz", opts = { silent = true } },
		["<C-u>"] = { "<C-u>zz", opts = { silent = true } },
		-- Keep cursor in the center line when going through search results
		["n"] = { "nzzzv", opts = { silent = true } },
		["N"] = { "Nzzzv", opts = { silent = true } },
		-- disable annoying command line typo
		["q:"] = { ":q", opts = { silent = true } },
		-- Easy replacement of a trailing ; or ,
		[";;"] = {
			function()
				require("chartoggle").toggle(";")
			end,
		},
		[",,"] = {
			function()
				require("chartoggle").toggle(",")
			end,
		},
	},

	i = {
		-- Escape insert
		["jk"] = { "<ESC>", "escape insert mode" },
	},

	v = {
		-- Move lines in Visual Mode
		["<S-Down>"] = { ":m '>+1<CR>gv=gv", opts = { silent = true } },
		["<S-Up>"] = { ":m '<-2<CR>gv=gv", opts = { silent = true } },
		["J"] = { ":m '>+1<CR>gv=gv", opts = { silent = true } },
		["K"] = { ":m '<-2<CR>gv=gv", opts = { silent = true } },
		-- Reselect visual selection after indenting
		["<"] = { "<gv", opts = { silent = true } },
		[">"] = { ">gv", opts = { silent = true } },
		-- Maintain the cursor position when yanking a visual selection
		["y"] = { "myy`y", opts = { silent = true } },
		-- Paste replace visual selection without coping it.
		["p"] = { '"_dP', opts = { silent = true } },
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

M.hop = {
	n = {
		["f"] = { "<cmd> lua require'hop'.hint_char1() <CR>", "Hop 1 char" },
		["F"] = { "<cmd> lua require'hop'.hint_char2() <CR>", "Hop 2 char" },
	},
}

return M
