local overrides = require("custom.configs.overrides")

return {

	----------------------------------------- default plugins ------------------------------------------
	"tpope/vim-sleuth",

	"tversteeg/registers.nvim",

	{
		"chrisgrieser/nvim-early-retirement",
		config = true,
		event = "VeryLazy",
	},

	{
		"ojroques/nvim-bufdel",
		event = "VeryLazy",
	},

	{
		"ojroques/nvim-osc52",
		event = "VeryLazy",
		opts = {
			silent = true,
		},
		config = function(_, opts)
			require("osc52").setup(opts)
			local function copy()
				if vim.v.event.operator == "y" and (vim.v.event.regname == "" or vim.v.event.regname == "+") then
					require("osc52").copy_register("+")
					vim.highlight.on_yank({ higroup = "HighlightYank", timeout = 100 })
				end
			end
			vim.api.nvim_create_autocmd("TextYankPost", { callback = copy })
		end,
	},

	{
		"mfussenegger/nvim-treehopper",
		keys = {
			{ "m", ":<C-U>lua require('tsht').nodes()<CR>", mode = "o" },
			{ "m", ":lua require('tsht').nodes()<CR>", mode = "v" },
		},
	},

	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lua",
			"windwp/nvim-autopairs",
			"hrsh7th/cmp-cmdline",
			"onsails/lspkind-nvim",
			{
				"zbirenbaum/copilot-cmp",
				config = function()
					require("copilot_cmp").setup()
				end,
			},
		},
		config = function()
			local cmp = require("cmp")
			local lsp_kind = require("lspkind")
			local cmp_next = function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif require("luasnip").expand_or_jumpable() then
					vim.fn.feedkeys(
						vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
						""
					)
				else
					fallback()
				end
			end
			local cmp_prev = function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif require("luasnip").jumpable(-1) then
					vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
				else
					fallback()
				end
			end
			lsp_kind.init()
			cmp.setup({
				enabled = function()
					local buftype = vim.api.nvim_buf_get_option(0, "buftype")
					if buftype == "prompt" then
						return false
					end
					return true
				end,
				preselect = cmp.PreselectMode.None,
				window = {
					completion = cmp.config.window.bordered({
						winhighlight = "Normal:Normal,FloatBorder:LspBorderBG,CursorLine:PmenuSel,Search:None",
					}),
					documentation = cmp.config.window.bordered({
						winhighlight = "Normal:Normal,FloatBorder:LspBorderBG,CursorLine:PmenuSel,Search:None",
					}),
				},
				view = {
					entries = "bordered",
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = {
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<S-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<tab>"] = cmp_next,
					["<down>"] = cmp_next,
					["<C-p>"] = cmp_prev,
					["<up>"] = cmp_prev,
					["<C-n>"] = cmp_next,
				},
				sources = {
					{ name = "nvim_lsp_signature_help", group_index = 1 },
					{ name = "luasnip", max_item_count = 5, group_index = 1 },
					{ name = "nvim_lsp", max_item_count = 20, group_index = 1 },
					{ name = "nvim_lua", group_index = 1 },
					{ name = "path", group_index = 2 },
					{ name = "buffer", keyword_length = 2, max_item_count = 5, group_index = 2 },
					{ name = "copilot", group_index = 1, priority = 100 },
				},
			})
			local presentAutopairs, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
			if not presentAutopairs then
				return
			end
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
			-- Enable command-line completion
			cmp.setup.cmdline(":", {
				sources = {
					{ name = "cmdline", keyword_length = 2 },
				},
				formatting = {
					fields = { "abbr" },
				},
			})
		end,
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
			{ "j-hui/fidget.nvim", tag = "legacy", opts = {} },
			"folke/neodev.nvim",
		},

		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
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

	-- override default configs
	{ "nvim-tree/nvim-tree.lua", opts = overrides.nvimtree },

	{
		"nvim-treesitter/nvim-treesitter",
		opts = overrides.treesitter,
		dependencies = {
			"windwp/nvim-ts-autotag",
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/nvim-treesitter-refactor",
			"hiphish/rainbow-delimiters.nvim",
			{
				"David-Kunz/treesitter-unit",
      -- stylua: ignore
      keys = {
        { mode = "x", "iu", ':lua require"treesitter-unit".select()<CR>',          { desc = "select in unit" } },
        { mode = "x", "au", ':lua require"treesitter-unit".select(true)<CR>',      { desc = "select around unit" } },
        { mode = "o", "iu", ':<c-u>lua require"treesitter-unit".select()<CR>',     { desc = "select in unit" } },
        { mode = "o", "au", ':<c-u>lua require"treesitter-unit".select(true)<CR>', { desc = "select around unit" } },
      },
			},
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

	{
		"folke/trouble.nvim",
		event = "VeryLazy",
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
			require("modicator").setup({})
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
		"nvim-zh/colorful-winsep.nvim",
		config = true,
		event = { "WinNew" },
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
		"machakann/vim-sandwich",
		event = "VeryLazy",
		keys = {
			{ "sa", desc = "Add surrounding", mode = { "n", "v" } },
			{ "sd", desc = "Delete surrounding" },
			{ "sr", desc = "Replace surrounding" },
		},
	},

	{
		"phaazon/hop.nvim",
		branch = "v2",
		opts = { keys = "etovxqpdygfblzhckisuran" },
	},

	{
		"utilyre/sentiment.nvim",
		event = "BufReadPre",
		config = function()
			require("sentiment").setup({})
		end,
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
		"aanari/ChatGPT.nvim",
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
				popup_layout = {
					default = "center",
					center = {
						width = "90%",
						height = "90%",
					},
					right = {
						width = "30%",
						width_settings_open = "50%",
					},
				},
				openai_params = {
					model = "openai/gpt-4-32k",
					max_tokens = 12000,
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
		"akinsho/flutter-tools.nvim",
		ft = "dart",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim", -- optional for vim.ui.select
		},
		config = function()
			require("flutter-tools").setup({})
		end,
	},

	{
		"chomosuke/term-edit.nvim",
		ft = "neoterm",
		version = "1.*",
		opts = {
			prompt_end = "❯ ",
		},
	},

	{
		"willothy/flatten.nvim",
		config = true,
		lazy = false,
		priority = 1001,
	},

	{
		"DanilaMihailov/beacon.nvim",
		cond = function()
			return not vim.g.neovide
		end,
		event = "WinEnter",
	},

	{
		"Xuyuanp/scrollbar.nvim",
		event = "WinScrolled",
		init = function() end,
		config = function()
			local scrollbar = require("scrollbar")

			vim.g.scrollbar_right_offset = 0
			vim.g.scrollbar_excluded_filetypes = { "NvimTree" }
			vim.g.scrollbar_highlight = {
				head = "Scrollbar",
				body = "Scrollbar",
				tail = "Scrollbar",
			}
			vim.g.scrollbar_shape = {
				head = "▖",
				body = "▌",
				tail = "▘",
			}

			local augroup = vim.api.nvim_create_augroup("Scrollbar", {})
			vim.api.nvim_create_autocmd({ "CursorMoved", "WinScrolled" }, {
				group = augroup,
				callback = function()
					return scrollbar.show()
				end,
			})
			vim.api.nvim_create_autocmd({
				"CursorHold",
				"BufLeave",
				"FocusLost",
				"VimResized",
				"QuitPre",
			}, {
				group = augroup,
				callback = scrollbar.clear,
			})
		end,
	},

	{
		"kdheepak/lazygit.nvim",
		cmd = "LazyGit",
	},

	{ "farmergreg/vim-lastplace", event = { "BufReadPre" } },

	{
		"monaqa/dial.nvim",
		keys = {
			{
				"<leader>di",
				function()
					return require("dial.map").inc_normal()
				end,
				expr = true,
			},
			{
				"<leader>dd",
				function()
					return require("dial.map").dec_normal()
				end,
				expr = true,
			},
			{
				"<leader>di",
				function()
					return require("dial.map").inc_visual()
				end,
				mode = "v",
				expr = true,
			},
			{
				"<leader>dd",
				function()
					return require("dial.map").dec_visual()
				end,
				mode = "v",
				expr = true,
			},
		},
		config = function()
			local augend = require("dial.augend")
			require("dial.config").augends:register_group({
				default = {
					augend.integer.alias.decimal,
					augend.constant.alias.bool,
					augend.constant.new({
						elements = { "True", "False" },
						word = true,
						cyclic = true,
					}),
					augend.semver.alias.semver,
					augend.date.alias["%Y/%m/%d"], -- date (2022/02/20, etc.)
					augend.constant.new({
						elements = { "and", "or" },
						word = true,
						cyclic = true,
					}),
					augend.constant.new({
						elements = { "&&", "||" },
						word = false,
						cyclic = true,
					}),
				},
			})
		end,
	},
}
