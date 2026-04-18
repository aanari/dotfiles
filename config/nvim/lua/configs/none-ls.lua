local null_ls = require "null-ls"

local format = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics
local eslint_format = require "none-ls.formatting.eslint_d"
local eslint_diagnostics = require "none-ls.diagnostics.eslint_d"
local eslint_actions = require "none-ls.code_actions.eslint_d"

local function root_has_file(files)
  return function(utils)
    return utils.root_has_file(files)
  end
end

local eslint_root_files = {
  ".eslintrc",
  ".eslintrc.js",
  ".eslintrc.cjs",
  ".eslintrc.json",
  "eslint.config.js",
  "eslint.config.cjs",
  "eslint.config.mjs",
}

local prettier_root_files = {
  ".prettierrc",
  ".prettierrc.js",
  ".prettierrc.cjs",
  ".prettierrc.json",
  "prettier.config.js",
  "prettier.config.cjs",
  "prettier.config.mjs",
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup {
  sources = {
    format.isort,
    format.black,
    format.gofmt,
    format.goimports_reviser,
    format.dart_format,
    format.protolint,
    format.clang_format,
    format.shellharden,
    format.rubyfmt,
    eslint_format.with {
      condition = root_has_file(eslint_root_files),
    },
    format.prettierd.with {
      condition = function(utils)
        local has_eslint = root_has_file(eslint_root_files)(utils)
        local has_prettier = root_has_file(prettier_root_files)(utils)
        return has_prettier and not has_eslint
      end,
    },
    format.stylua,
    format.shfmt,
    format.yamlfmt,

    lint.stylelint.with {
      filetypes = { "css", "scss" },
    },
    eslint_diagnostics.with {
      condition = root_has_file(eslint_root_files),
    },
    require "none-ls-shellcheck.diagnostics",
    require "none-ls-shellcheck.code_actions",
    lint.yamllint,
    lint.sqlfluff.with {
      extra_args = { "--dialect", "postgres" },
    },

    eslint_actions.with {
      condition = root_has_file(eslint_root_files),
    },
  },
  on_attach = function(client, bufnr)
    if client:supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format {
            filter = function(active_client)
              return active_client.name == "null-ls"
            end,
            bufnr = bufnr,
          }
        end,
      })
    end
  end,
}
