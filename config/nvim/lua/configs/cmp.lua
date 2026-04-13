local cmp = require "cmp"
local luasnip = require "luasnip"

local function cmp_next(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  elseif luasnip.expand_or_jumpable() then
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
  else
    fallback()
  end
end

local function cmp_prev(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  elseif luasnip.jumpable(-1) then
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
  else
    fallback()
  end
end

return {
  enabled = function()
    return vim.bo.buftype ~= "prompt"
  end,
  preselect = cmp.PreselectMode.None,
  window = {
    completion = cmp.config.window.bordered {
      winhighlight = "Normal:Normal,FloatBorder:LspBorderBG,CursorLine:PmenuSel,Search:None",
    },
    documentation = cmp.config.window.bordered {
      winhighlight = "Normal:Normal,FloatBorder:LspBorderBG,CursorLine:PmenuSel,Search:None",
    },
  },
  view = {
    entries = "bordered",
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<S-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<Tab>"] = cmp.mapping(cmp_next, { "i", "s" }),
    ["<Down>"] = cmp.mapping(cmp_next, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(cmp_prev, { "i", "s" }),
    ["<Up>"] = cmp.mapping(cmp_prev, { "i", "s" }),
    ["<C-p>"] = cmp.mapping(cmp_prev, { "i", "s" }),
    ["<C-n>"] = cmp.mapping(cmp_next, { "i", "s" }),
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp_signature_help", group_index = 1 },
    { name = "luasnip", max_item_count = 5, group_index = 1 },
    { name = "nvim_lsp", max_item_count = 20, group_index = 1 },
    { name = "nvim_lua", group_index = 1 },
    { name = "path", group_index = 2 },
    { name = "buffer", keyword_length = 2, max_item_count = 5, group_index = 2 },
  }),
}
