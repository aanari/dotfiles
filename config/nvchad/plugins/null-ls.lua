local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {
  b.formatting.black,
  b.formatting.clang_format,
  b.formatting.isort,
  b.formatting.rustfmt,
  b.formatting.stylua,
  b.formatting.prettierd.with {
     filetypes = { "html", "json", "markdown", "scss", "css", "typescript" },
  },
  b.diagnostics.eslint.with {
     command = "eslint_d",
  },
  b.formatting.shfmt,
  b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },
}

null_ls.setup {
  debug = true,
  sources = sources,
}
