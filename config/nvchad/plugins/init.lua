return {
	-- autoclose tags in html, jsx etc
	["windwp/nvim-ts-autotag"] = {
		ft = { "html", "javascriptreact" },
		after = "nvim-treesitter",
		config = function()
			require("custom.plugins.smolconfigs").autotag()
		end,
	},

	-- format & linting
	["jose-elias-alvarez/null-ls.nvim"] = {
		after = "nvim-lspconfig",
		config = function()
			require("custom.plugins.null-ls")
		end,
	},

	-- minimal modes
	["Pocco81/TrueZen.nvim"] = {
		cmd = {
			"TZAtaraxis",
			"TZMinimalist",
			"TZFocus",
		},
		config = function()
			require("custom.plugins.truezen")
		end,
	},

	-- get highlight group under cursor
	["nvim-treesitter/playground"] = {
		cmd = "TSCaptureUnderCursor",
		config = function()
			require("nvim-treesitter.configs").setup()
		end,
	},

	-- notes stuff
	["nvim-neorg/neorg"] = {
		ft = "norg",
		after = "nvim-treesitter",
		config = function()
			require("custom.plugins.neorg")
		end,
	},

	["goolord/alpha-nvim"] = {
		disable = false,
		cmd = "Alpha",
	},

	["neovim/nvim-lspconfig"] = {
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.plugins.lspconfig")
		end,
	},

	["f-person/git-blame.nvim"] = {},
	["alexghergh/nvim-tmux-navigation"] = {
		keybindings = {
			left = "<C-h>",
			down = "<C-j>",
			up = "<C-k>",
			right = "<C-l>",
			last_active = "<C-\\>",
			next = "<C-Space>",
		},
	},

	["ojroques/vim-oscyank"] = {},

	["ojroques/nvim-osc52"] = {
		config = function()
			require("osc52").setup()
			local function copy()
				if vim.v.event.operator == "y" and vim.v.event.regname == "" then
					require("osc52").copy_register('"')
				end
			end

			vim.api.nvim_create_autocmd("TextYankPost", { callback = copy })
		end,
	},

	["ellisonleao/glow.nvim"] = {},

	["petertriho/nvim-scrollbar"] = {
		config = function()
			require("scrollbar").setup()
		end,
	},

	["max397574/better-escape.nvim"] = {
		config = function()
			require("better_escape").setup()
		end,
	},

	["ruifm/gitlinker.nvim"] = {
		opts = {
			action_callback = function(url)
				vim.api.nvim_command("let @\" = '" .. url .. "'")
				vim.fn.OSCYankString(url)
			end,
		},
	},
}
