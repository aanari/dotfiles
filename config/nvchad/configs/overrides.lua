-- overriding default plugin configs!

local M = {}

M.treesitter = {
	ensure_installed = {
		"vim",
		"html",
		"css",
		"javascript",
		"json",
		"toml",
		"markdown",
		"c",
		"go",
		"bash",
		"lua",
		"tsx",
		"typescript",
		"python",
	},
	rainbow = {
		enable = true,
		query = {
			"rainbow-parens",
			html = "rainbow-tags",
			javascript = "rainbow-tags-react",
			tsx = "rainbow-tags",
		},
	},
}

M.nvimtree = {
	filters = {
		dotfiles = true,
		custom = { "node_modules" },
	},

	git = {
		enable = true,
	},

	renderer = {
		highlight_git = true,
		icons = {
			show = {
				git = true,
			},
		},
	},
}

M.mason = {
	ensure_installed = {
		-- python
		"pylint",
		"pyright",

		-- lua stuff
		"lua-language-server",
		"stylua",

		-- web dev
		"css-lsp",
		"html-lsp",
		"typescript-language-server",
		"deno",
		"prettier",
		-- "emmet-ls",
		"json-lsp",
		"tailwindcss-language-server",

		-- shell
		"shfmt",
		"shellcheck",
		"bash-language-server",

		"clangd",
		"clang-format",
	},
}

return M
