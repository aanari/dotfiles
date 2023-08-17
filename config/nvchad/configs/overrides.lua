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
		"ruby",
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
	autotag = {
		enable = true,
	},
	highlight = { enable = true },
	indent = { enable = true },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<CR>",
			node_incremental = "<CR>",
			scope_incremental = false,
			node_decremental = "<BS>",
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
		"graphql-language-service-cli",
		"html-lsp",
		"isort",
		"jq",
		"json-lsp",
		"jsonlint",
		"lua-language-server",
		"prettier",
		"protolint",
		"pyright",
		"rubyfmt",
		"shellcheck",
		"shellharden",
		"shfmt",
		"sqlfluff",
		"stylua",
		"tailwindcss-language-server",
		"tree-sitter-cli",
		"typescript-language-server",
		"yaml-language-server",
		"yamlfmt",
		"yamllint",
	},
}

return M
