require "nvchad.options"

local o = vim.o
local opt = vim.opt

if not vim.env.GOROOT or vim.fn.isdirectory(vim.env.GOROOT) == 0 then
  if vim.fn.isdirectory "/opt/homebrew/opt/go/libexec" == 1 then
    vim.env.GOROOT = "/opt/homebrew/opt/go/libexec"
  elseif vim.fn.isdirectory "/usr/local/go" == 1 then
    vim.env.GOROOT = "/usr/local/go"
  end
end

local mason_bin = vim.fn.stdpath "data" .. "/mason/bin"
if vim.fn.isdirectory(mason_bin) == 1 and not vim.env.PATH:find(vim.pesc(mason_bin), 1, true) then
  vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
end

if vim.env.GOROOT then
  local goroot_bin = vim.env.GOROOT .. "/bin"
  if vim.fn.isdirectory(goroot_bin) == 1 and not vim.env.PATH:find(vim.pesc(goroot_bin), 1, true) then
    vim.env.PATH = goroot_bin .. ":" .. vim.env.PATH
  end
end

local icons = {
  [vim.diagnostic.severity.ERROR] = "",
  [vim.diagnostic.severity.WARN] = "󰀦",
  [vim.diagnostic.severity.INFO] = "󰌶",
  [vim.diagnostic.severity.HINT] = "󱞩",
}

vim.diagnostic.config {
  virtual_text = {
    prefix = "",
    spacing = 2,
    source = "if_many",
  },
  signs = { text = icons },
  underline = true,
  severity_sort = true,
  float = {
    border = "single",
    source = "if_many",
  },
}

o.mouse = "a"
o.breakindent = true
o.swapfile = false
o.showmode = false
o.updatetime = 200
o.timeoutlen = 300
o.title = true
o.guifont = "PragmataProMonoLiga Nerd Font"
o.cursorline = false
o.cursorcolumn = false
o.termguicolors = true

opt.shortmess:append "A"
opt.shortmess:append "s"
opt.shortmess:append "cS"
opt.shortmess:append "FW"

if vim.env.TMUX then
  local copy = { "tmux", "load-buffer", "-w", "-" }
  local paste = { "tmux", "save-buffer", "-" }

  vim.g.clipboard = {
    name = "tmux",
    copy = {
      ["+"] = copy,
      ["*"] = copy,
    },
    paste = {
      ["+"] = paste,
      ["*"] = paste,
    },
    cache_enabled = 0,
  }
  opt.clipboard = "unnamedplus"
elseif vim.env.SSH_TTY then
  opt.clipboard = ""
else
  opt.clipboard = "unnamedplus"
end

opt.guicursor = {
  [[n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50]],
  [[a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor]],
  [[sm:block-blinkwait175-blinkoff150-blinkon175]],
}
