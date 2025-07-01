local null_ls = require("null-ls")

local format = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics
local code = null_ls.builtins.code_actions
local eslint_d = require("none-ls.diagnostics.eslint_d")

local root_has_file = function(files)
	return function(utils)
		return utils.root_has_file(files)
	end
end

local eslint_root_files = { ".eslintrc", ".eslintrc.js", ".eslintrc.json" }
local prettier_root_files = { ".prettierrc", ".prettierrc.js", ".prettierrc.json" }

local sources = {
	-- Formatting
	format.isort,
	format.black,
	format.gofmt,
	format.goimports_reviser,
	format.dart_format,
	format.protolint,
	format.clang_format,
	format.shellharden,
	format.rubyfmt,
	eslint_d.with({
		condition = root_has_file(eslint_root_files),
	}),
	format.prettierd.with({
		condition = function(utils)
			local has_eslint = root_has_file(eslint_root_files)(utils)
			local has_prettier = root_has_file(prettier_root_files)(utils)
			return has_prettier and not has_eslint
		end,
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
	eslint_d.with({
		condition = root_has_file(eslint_root_files),
	}),
  require("none-ls-shellcheck.diagnostics"),
  require("none-ls-shellcheck.code_actions"),
	lint.yamllint,
	lint.sqlfluff.with({
		extra_args = { "--dialect", "postgres" },
	}),

	-- Code Actions
	eslint_d.with({
		condition = root_has_file(eslint_root_files),
	}),
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
	sources = sources,
	on_attach = function(current_client, bufnr)
		if current_client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						filter = function(client)
							return client.name == "null-ls"
						end,
						bufnr = bufnr,
					})
				end,
			})
		end
	end,
})
