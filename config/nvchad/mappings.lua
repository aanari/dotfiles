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
		["<Esc>"] = { ":noh <CR>", "Clear highlights", opts = { silent = true } },
		["<BS>"] = { ":noh <CR>", "Clear highlights", opts = { silent = true } },
		["<CR>"] = {
			function()
				if vim.bo.buftype == "terminal" then
					vim.cmd("startinsert!")
				else
					vim.cmd("noh")
				end
			end,
			opts = { silent = true },
		},
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
			"Toggle ; at the end of the line",
		},
		[",,"] = {
			function()
				require("chartoggle").toggle(",")
			end,
			"Toggle , at the end of the line",
		},
		["<leader>qf"] = { ":TroubleToggle<cr>", "Quick Fix" },
		["<leader>fm"] = {
			function()
				vim.lsp.buf.format({ async = true, timeout_ms = 5000 })
			end,
			"LSP formatting",
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

	t = {
		["<C-a>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "Escape terminal mode" },
	},
}

M.chatgpt = {
	n = {
		-- ChatGPT
		["<leader>gp"] = {
			function()
				require("chatgpt").openChat()
			end,
			"Open ChatGPT window",
		},
	},
	v = {
		["<leader>gpc"] = {
			function()
				vim.cmd.ChatGPTRun("code")
			end,
			"Complete Code",
		},
		["<leader>gpd"] = {
			function()
				vim.cmd.ChatGPTRun("docstring")
			end,
			"Docstring",
		},
		["<leader>gpg"] = {
			function()
				vim.cmd.ChatGPTRun("grammar")
			end,
			"Correct Grammar",
		},
		["<leader>gpk"] = {
			function()
				vim.cmd.ChatGPTRun("keywords")
			end,
			"Extract Keywords",
		},
		["<leader>gpt"] = {
			function()
				vim.cmd.ChatGPTRun("tests")
			end,
			"Add Tests",
		},
		["<leader>gpo"] = {
			function()
				vim.cmd.ChatGPTRun("optimize")
			end,
			"Optimize Code",
		},
		["<leader>gps"] = {
			function()
				vim.cmd.ChatGPTRun("summarize")
			end,
			"Summarize Content",
		},
		["<leader>gpb"] = {
			function()
				vim.cmd.ChatGPTRun("bugs")
			end,
			"Fix Bugs",
		},
		["<leader>gpe"] = {
			function()
				vim.cmd.ChatGPTRun("explain")
			end,
			"Explain Code",
		},
		["<leader>gpa"] = {
			function()
				vim.cmd.ChatGPTRun("analyze")
			end,
			"Analyze Code",
		},
		["<leader>gpE"] = {
			function()
				require("chatgpt").edit_with_instructions()
			end,
			"Edit Code",
		},
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

M.flutter = {
	n = {
		["<leader>Fd"] = { ":FlutterOpenDevTools<cr>", "Flutter Dev Tools" },
		["<leader>Fe"] = { ":FlutterEmulators<cr>", "Flutter Emulators" },
		["<leader>Fr"] = { ":FlutterRun<cr>", "Flutter Run" },
		["<leader>Fq"] = { ":FlutterQuit<cr>", "Flutter Quit" },
		["<leader>FR"] = { ":FlutterRestart<cr>", "Flutter Restart" },
		["<leader>FC"] = { ":FlutterLogClear<cr>", "Flutter Clear Log" },
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

M.gitsigns = {
	n = {
		["<leader>gb"] = {
			function()
				package.loaded.gitsigns.blame_line()
			end,
			"Blame line",
		},
	},
}

M.lazygit = {
	n = {
		["<leader>gg"] = { ":LazyGit<cr>", "Lazy Git" },
	},
}

M.telescope = {
	n = {
		["<leader>fz"] = { "<cmd> Telescope grep_string <CR>", "Grep under cursor" },
	},

	v = {
		["<leader>fz"] = { "y<ESC>:Telescope live_grep default_text=<c-r>0<CR>" },
	},
}

return M
