local nvchad_lsp = require "nvchad.configs.lspconfig"

local lsp_cache = vim.g.base46_cache .. "lsp"
if vim.uv.fs_stat(lsp_cache) then
  dofile(lsp_cache)
end


vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    nvchad_lsp.on_attach(client, args.buf)

    if client:supports_method "textDocument/semanticTokens" then
      client.server_capabilities.semanticTokensProvider = nil
      vim.lsp.semantic_tokens.stop(args.buf, client.id)
    end

    if not client:supports_method("textDocument/documentHighlight", args.buf) then
      return
    end

    local group = vim.api.nvim_create_augroup(
      string.format("dotfiles_lsp_highlight_%d_%d", args.data.client_id, args.buf),
      { clear = true }
    )

    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = args.buf,
      group = group,
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter" }, {
      buffer = args.buf,
      group = group,
      callback = vim.lsp.buf.clear_references,
    })

    vim.api.nvim_create_autocmd("LspDetach", {
      buffer = args.buf,
      group = group,
      callback = function()
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds { group = group, buffer = args.buf }
      end,
    })
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
