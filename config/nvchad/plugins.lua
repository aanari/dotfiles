local overrides = require("custom.configs.overrides")

return {

	----------------------------------------- default plugins ------------------------------------------
	{
		"hrsh7th/nvim-cmp",
		opts = {
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "nvim_lua" },
				{ name = "path" },
				{ name = "copilot" },
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				-- format & linting
				"jose-elias-alvarez/null-ls.nvim",
				config = function()
					require("custom.configs.null-ls")
				end,
			},
			{
				"zbirenbaum/copilot-cmp",
				config = function()
					require("copilot_cmp").setup()
				end,
			},
		},

		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end,
	},

	-- override default configs
	{ "nvim-tree/nvim-tree.lua", opts = overrides.nvimtree },

	{
		"nvim-treesitter/nvim-treesitter",
		opts = overrides.treesitter,
		dependencies = {
			"HiPhish/nvim-ts-rainbow2",
			"windwp/nvim-ts-autotag",
		},
	},

	{ "williamboman/mason.nvim", opts = overrides.mason },

	--------------------------------------------- custom plugins ----------------------------------------------

	-- autoclose tags in html, jsx only
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},

	-- get highlight group under cursor
	{
		"nvim-treesitter/playground",
		cmd = "TSCaptureUnderCursor",
		config = function()
			require("nvim-treesitter.configs").setup()
		end,
	},

	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		config = function()
			require("trouble").setup()
		end,
	},

	{
		"numToStr/Navigator.nvim",
		cmd = { "NavigatorLeft", "NavigatorRight", "NavigatorUp", "NavigatorDown" },
		config = function()
			require("Navigator").setup()
		end,
	},

	{
		"nmac427/guess-indent.nvim",
		event = "VeryLazy",
		config = function()
			require("guess-indent").setup({})
		end,
	},

	{
		"ellisonleao/glow.nvim",
		cmd = "Glow",
		config = function()
			require("glow").setup({
				style = "dark",
				width = 120,
			})
		end,
	},

	{
		"melkster/modicator.nvim",
		event = "VeryLazy",
		dependencies = "NvChad/base46",
		init = function()
			vim.o.number = true
			vim.o.cursorline = true
			vim.o.termguicolors = true
		end,
		config = function()
			require("modicator").setup({
				highlights = {
					-- Default options for bold/italic
					defaults = {
						bold = true,
						italic = false,
					},
				},
			})
		end,
	},

	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = { "BufReadPost", "BufNewFile" },
		config = true,
		keys = {
			{
				"]t",
				function()
					require("todo-comments").jump_next()
				end,
				desc = "Next todo comment",
			},
			{
				"[t",
				function()
					require("todo-comments").jump_prev()
				end,
				desc = "Previous todo comment",
			},
			{ "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
		},
	},

	{
		"tummetott/reticle.nvim",
		event = "VeryLazy",
	},

	{
		"kevinhwang91/nvim-hlslens",
		event = "VeryLazy",
		config = function()
			require("hlslens").setup()
		end,
	},

	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("illuminate").configure({
				filetypes_denylist = { "NvimTree", "dirvish", "fugitive" },
				delay = 0,
				under_cursor = false,
			})

			local function map(key, dir, buffer)
				vim.keymap.set("n", key, function()
					require("illuminate")["goto_" .. dir .. "_reference"](false)
				end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
			end

			map("]]", "next")
			map("[[", "prev")

			-- also set it after loading ftplugins, since a lot overwrite [[ and ]]
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					local buffer = vim.api.nvim_get_current_buf()
					map("]]", "next", buffer)
					map("[[", "prev", buffer)
				end,
			})
		end,
		keys = {
			{ "]]", desc = "Next Reference" },
			{ "[[", desc = "Prev Reference" },
		},
	},

	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},

	{
		"folke/zen-mode.nvim",
		config = true,
		event = "VeryLazy",
		keys = {
			{
				"<leader>zz",
				function()
					require("zen-mode").toggle()

					vim.wo.wrap = false
					vim.wo.number = true
					vim.wo.rnu = true
				end,
			},
			{
				"<leader>zZ",
				function()
					require("zen-mode").toggle()

					vim.wo.wrap = false
					vim.wo.number = false
					vim.wo.rnu = false
				end,
			},
		},
	},

	{
		"folke/twilight.nvim",
		enabled = true,
		keys = {
			{ "<leader>wt", "<cmd>Twilight<cr>", desc = "Toggle Twilight" },
		},
		opts = { context = 12 },
	},

	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		event = "BufReadPre",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		config = function()
			require("barbecue").setup({
				create_autocmd = true,
			})
		end,
	},

	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},

	{
		"phaazon/hop.nvim",
		branch = "v2",
		cmd = "HopWord",
		config = function()
			require("hop").setup()
		end,
	},

	{
		"utilyre/sentiment.nvim",
		event = "BufReadPre",
		config = function()
			require("sentiment").setup({})
		end,
	},

	{
		"xiyaowong/virtcolumn.nvim",
		event = "BufReadPre",
	},

	{
		"saifulapm/chartoggle.nvim",
		event = "BufEnter",
		config = function()
			require("chartoggle").setup({
				leader = "<leader>",
				keys = { ",", ";" },
			})
		end,
	},

	{
		"Wansmer/treesj",
		keys = { "<space>m", "<space>j", "<space>s" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesj").setup({--[[ your config ]]
			})
		end,
	},

	{
		"weilbith/nvim-code-action-menu",
		cmd = "CodeActionMenu",
	},

	{
		"jackMort/ChatGPT.nvim",
		cmd = {
			"ChatGPT",
			"ChatGPTActAs",
			"ChatGPTCompleteCode",
			"ChatGPTEditWithInstructions",
			"ChatGPTRun",
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("chatgpt").setup({
				chat = {
					welcome_message = "",
				},
				openai_params = {
					model = "gpt-3.5-turbo-16k",
					max_tokens = 4000,
					frequency_penalty = 0,
					presence_penalty = 0,
					temperature = 0,
					top_p = 1,
					n = 1,
				},
				actions_paths = { "~/.config/nvim/lua/custom/configs/actions.json" },
			})
		end,
	},

	{
		"jghauser/mkdir.nvim",
		event = { "FileWritePre", "BufWritePre" },
		config = function()
			require("mkdir")
		end,
	},

	{
		"ruifm/gitlinker.nvim",
		event = "BufRead",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			action_callback = function(url)
				-- yank to unnamed register
				vim.api.nvim_command("let @\" = '" .. url .. "'")
				-- copy to the system clipboard using OSC52
				vim.fn.OSCYankString(url)
			end,
		},
	},

	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		build = ":Copilot auth",
		opts = {
			suggestion = {
				enabled = false,
			},
			panel = {
				enabled = false,
			},
		},
	},

	{
		"gelguy/wilder.nvim",
		event = "CmdlineEnter",
		build = ":UpdateRemotePlugins",
		config = function()
			local wilder = require("wilder")
			wilder.setup({
				modes = { ":", "/", "?" },
			})
		end,
	},
}
