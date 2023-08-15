-- overriding default plugin configs!

local M = {}

M.treesitter = {
	ensure_installed = {
		"awk",
		"bash",
		"c",
		"cpp",
		"css",
		"dart",
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
	autotag = {
		enable = true,
	},
	highlight = { enable = true },
	indent = { enable = true },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-space>",
			node_incremental = "<C-space>",
			scope_incremental = false,
			node_decremental = "<bs>",
		},
	},
}

M.nvimtree = {
	actions = {
		open_file = {
			resize_window = true,
		},
	},
	filters = {
		dotfiles = false,
		custom = { "node_modules", "env", "venv" },
	},
	view = {
		adaptive_size = true,
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
		"black",
		"clang-format",
		"clangd",
		"css-lsp",
		"deno",
		"eslint_d",
		"fixjson",
		"flake8",
		"goimports-reviser",
		"html-lsp",
		"isort",
		"jq",
		"json-lsp",
		"jsonlint",
		"lua-language-server",
		"prettier",
		"protolint",
		"pyright",
		"shellcheck",
		"shellharden",
		"sqlfluff",
		"shfmt",
		"stylua",
		"tailwindcss-language-server",
		"typescript-language-server",
		"yamlfmt",
		"yamllint",
	},
}

return M
