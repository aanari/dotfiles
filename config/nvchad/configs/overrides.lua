-- overriding default plugin configs!

local M = {}

M.treesitter = {
	ensure_installed = {
		"awk",
		"bash",
		"c",
		"cpp",
		"css",
		"dockerfile",
		"go",
		"html",
		"javascript",
		"json",
		"lua",
		"markdown",
		"markdown_inline",
		"python",
		"query",
		"regex",
		"scss",
		"sql",
		"toml",
		"tsx",
		"typescript",
		"vim",
		"yaml",
		"git_rebase",
		"gitcommit",
		"gitignore",
		"json5",
		"jsonc",
		"rust",
		"vue",
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
		"bash-language-server",
		"clang-format",
		"clangd",
		"css-lsp",
		"deno",
		"html-lsp",
		"json-lsp",
		"lua-language-server",
		"prettier",
		"pyright",
		"shellcheck",
		"shfmt",
		"stylua",
		"tailwindcss-language-server",
		"typescript-language-server",
		"goimports-reviser",
		"protolint",
		"shellharden",
	},
}

return M
