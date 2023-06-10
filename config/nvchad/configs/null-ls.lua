local null_ls = require("null-ls")

local format = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics

local sources = {
	format.black,
	format.isort,
	format.dart_format,
	format.gofmt,
	format.goimports_reviser,
	format.dart_format,
	format.jq,
	format.protolint,
	format.shellharden,
	format.stylelint,
	lint.protoc_gen_lint,
	lint.eslint.with({
		command = "eslint_d",
	}),
	format.deno_fmt,
	format.prettier.with({ filetypes = { "html", "markdown", "css" } }),
	format.stylua,
	format.shfmt,
	lint.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),
	lint.clang_check,
	format.clang_format,
	lint.yamllint,
	lint.sqlfluff.with({
		extra_args = { "--dialect", "postgres" }, -- change to your dialect
	}),
}

null_ls.setup({
	debug = true,
	sources = sources,
})
