local nvchad_lsp = require "nvchad.configs.lspconfig"

local lsp_cache = vim.g.base46_cache .. "lsp"
if vim.uv.fs_stat(lsp_cache) then
  dofile(lsp_cache)
end


vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    nvchad_lsp.on_attach(nil, args.buf)
  end,
})

vim.lsp.config("*", {
  capabilities = nvchad_lsp.capabilities,
  on_init = nvchad_lsp.on_init,
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = {
        library = {
          vim.fn.expand "$VIMRUNTIME/lua",
          vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
          vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
          "${3rd}/luv/library",
        },
      },
    },
  },
})

vim.lsp.enable "lua_ls"

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
  "rust_analyzer",
  "stylelint_lsp",
  "tailwindcss",
  "ts_ls",
  "unocss",
  "yamlls",
}

for _, server in ipairs(servers) do
  vim.lsp.enable(server)
end
