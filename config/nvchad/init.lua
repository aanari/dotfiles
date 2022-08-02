-- commands

local opt_local = vim.opt_local

-- autocmds
-- pretty up norg ft!
autocmd("FileType", {
  pattern = "norg",
  callback = function()
    opt_local.number = false
    opt_local.cole = 1
    opt_local.foldlevel = 10
    opt_local.foldenable = false
    opt_local.signcolumn = "yes:2"
  end,
})
