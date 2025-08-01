local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
local servers = {
	"bashls",
	"clangd",
	"cssls",
	"dartls",
	"eslint",
	"gopls",
	"html",
	"jsonls",
	"pyright",
	"rls",
	"stylelint_lsp",
	"tailwindcss",
	"ts_ls",
	"unocss",
	"yamlls",
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end
