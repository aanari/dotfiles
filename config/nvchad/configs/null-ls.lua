local null_ls = require("null-ls")

local format = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics
local code = null_ls.builtins.code_actions

local sources = {
	-- Formatting
	format.isort,
	format.black,
	format.gofmt,
	format.goimports_reviser,
	format.dart_format,
	format.fixjson,
	format.jq,
	format.protolint,
	format.clang_format,
	format.shellharden,
	format.deno_fmt,
	format.prettier.with({
		filetypes = {
			"javascript",
			"typescript",
			"css",
			"scss",
			"html",
			"json",
			"yaml",
			"markdown",
			"graphql",
			"md",
			"txt",
		},
		only_local = "node_modules/.bin",
	}),
	format.stylua,
	format.shfmt,
	format.yamlfmt,

	-- Diagnostics
	lint.stylelint.with({
		filetypes = {
			"css",
			"scss",
		},
	}),
	lint.protoc_gen_lint,
	lint.eslint_d.with({
		condition = function(utils)
			return utils.root_has_file(".eslintrc.js")
		end,
	}),
	lint.flake8,
	lint.tsc,
	lint.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),
	lint.clang_check,
	lint.yamllint,
	lint.sqlfluff.with({
		extra_args = { "--dialect", "postgres" },
	}),

	-- Code Actions
	code.gitsigns,
	code.gitrebase,
}

null_ls.setup({
	debug = true,
	sources = sources,
	on_attach = function()
		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function()
				vim.lsp.buf.format()
			end,
		})
	end,
})
