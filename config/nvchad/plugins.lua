local overrides = require("custom.configs.overrides")

return {

	----------------------------------------- default plugins ------------------------------------------
	{
		"hrsh7th/nvim-cmp",
		opts = {
			sources = {
				-- trigger_characters is for unocss lsp
				{ name = "nvim_lsp", trigger_characters = { "-" } },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "nvim_lua" },
				{ name = "path" },
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
		"ojroques/nvim-osc52",
		lazy = false,
		config = function()
			require("osc52").setup({
				silent = true,
			})
		end,
	},

	{
		"ruifm/gitlinker.nvim",
		lazy = false,
		config = function()
			require("gitlinker").setup({
				action_callback = function(url)
					vim.api.nvim_command("let @\" = '" .. url .. "'")
					require("osc52").copy(url)
				end,
			})
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
		"f-person/git-blame.nvim",
		config = function()
			vim.g.gitblame_message_template = "          <author>, <date> • <summary>"
			vim.g.gitblame_date_format = "%r"
			vim.g.gitblame_ignored_filetypes = { "NvimTree", "netrw", "packer" }
			vim.g.gitblame_set_extmark_options = {
				hl_mode = "combine",
				priority = 10000,
			}
		end,
		event = "BufEnter",
	},

	{
		"melkster/modicator.nvim",
		lazy = false,
		init = function()
			vim.o.number = true
			vim.o.cursorline = true
		end,
		config = function()
			require("modicator").setup()
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
		"ggandor/leap.nvim",
		keys = {
			{ "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
			{ "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
			{ "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
		},
		config = function(_, opts)
			local leap = require("leap")
			for k, v in pairs(opts) do
				leap.opts[k] = v
			end
			leap.add_default_mappings(true)
			vim.keymap.del({ "x", "o" }, "x")
			vim.keymap.del({ "x", "o" }, "X")
		end,
	},

	{
		"ggandor/flit.nvim",
		keys = function()
			---@type LazyKeys[]
			local ret = {}
			for _, key in ipairs({ "f", "F", "t", "T" }) do
				ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
			end
			return ret
		end,
		opts = { labeled_modes = "nx" },
	},

	{
		"echasnovski/mini.indentscope",
		version = false, -- wait till new 0.7.0 release to put it back on semver
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			-- symbol = "▏",
			symbol = "│",
			options = { try_as_border = true },
			draw = {
				delay = 0,
				animation = function()
					return 0
				end,
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
		config = function(_, opts)
			require("mini.indentscope").setup(opts)
		end,
	},

	{
		"tummetott/reticle.nvim",
		event = "VeryLazy",
	},

	{
		"kevinhwang91/nvim-hlslens",
		config = function()
			require("hlslens").setup()
		end,
	},

	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile" },
		opts = { delay = 200 },
		config = function()
			require("illuminate").configure({ filetypes_denylist = { "NvimTree", "dirvish", "fugitive" } })

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
}
