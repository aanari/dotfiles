require "nvchad.mappings"

local map = vim.keymap.set

local function toggle_trailing_char(char)
  local line = vim.api.nvim_get_current_line()
  local trimmed = line:gsub("%s*$", "")
  local suffix = line:sub(#trimmed + 1)

  if trimmed:sub(-#char) == char then
    vim.api.nvim_set_current_line(trimmed:sub(1, -#char - 1) .. suffix)
  else
    vim.api.nvim_set_current_line(trimmed .. char .. suffix)
  end
end

map("n", "<Esc>", "<cmd>noh<CR>", { silent = true, desc = "Clear highlights" })
map("n", "<BS>", "<cmd>noh<CR>", { silent = true, desc = "Clear highlights" })
map("n", "<CR>", function()
  if vim.bo.buftype == "terminal" then
    vim.cmd "startinsert!"
  else
    vim.cmd "noh"
  end
end, { silent = true, desc = "Clear highlights or re-enter terminal insert" })

map("n", "<C-d>", "<C-d>zz", { silent = true, desc = "Scroll down centered" })
map("n", "<C-u>", "<C-u>zz", { silent = true, desc = "Scroll up centered" })
map("n", "n", "nzzzv", { silent = true, desc = "Next search result centered" })
map("n", "N", "Nzzzv", { silent = true, desc = "Prev search result centered" })
map("n", "q:", ":q", { silent = true, desc = "Avoid command-line window" })

map("n", ";;", function()
  toggle_trailing_char ";"
end, { desc = "Toggle trailing semicolon" })
map("n", ",,", function()
  toggle_trailing_char ","
end, { desc = "Toggle trailing comma" })
map("n", "<leader>qf", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics list" })
map("n", "gl", function()
  vim.diagnostic.open_float(nil, { focus = false, scope = "line" })
end, { desc = "Line diagnostics" })
map("n", "<leader>fm", function()
  vim.lsp.buf.format { async = true, timeout_ms = 5000 }
end, { desc = "LSP formatting" })

map("i", "jk", "<ESC>", { desc = "Exit insert mode" })

map("v", "<S-Down>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
map("v", "<S-Up>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })
map("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })
map("v", "<", "<gv", { silent = true, desc = "Indent left and reselect" })
map("v", ">", ">gv", { silent = true, desc = "Indent right and reselect" })
map("v", "p", '"_dP', { silent = true, desc = "Paste without yanking replaced text" })

map("t", "<C-a>", vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), { desc = "Exit terminal mode" })

map("n", "<leader>cu", "<cmd>TSCaptureUnderCursor<CR>", { desc = "Treesitter capture under cursor" })
map("n", "<leader>gc", function()
  require("nvterm.terminal").send("clear && g++ -o out " .. vim.fn.expand "%" .. " && ./out", "vertical")
end, { desc = "Compile and run current C++ file" })

map("n", "<leader>Fd", "<cmd>FlutterOpenDevTools<CR>", { desc = "Flutter Dev Tools" })
map("n", "<leader>Fe", "<cmd>FlutterEmulators<CR>", { desc = "Flutter Emulators" })
map("n", "<leader>Fr", "<cmd>FlutterRun<CR>", { desc = "Flutter Run" })
map("n", "<leader>Fq", "<cmd>FlutterQuit<CR>", { desc = "Flutter Quit" })
map("n", "<leader>FR", "<cmd>FlutterRestart<CR>", { desc = "Flutter Restart" })
map("n", "<leader>FC", "<cmd>FlutterLogClear<CR>", { desc = "Flutter Clear Log" })

map("n", "H", "^", { desc = "Beginning of line" })
map("n", "L", "$", { desc = "End of line" })

map({ "n", "t" }, "<C-h>", "<cmd>NavigatorLeft<CR>", { desc = "Navigate left" })
map({ "n", "t" }, "<C-j>", "<cmd>NavigatorDown<CR>", { desc = "Navigate down" })
map({ "n", "t" }, "<C-k>", "<cmd>NavigatorUp<CR>", { desc = "Navigate up" })
map({ "n", "t" }, "<C-l>", "<cmd>NavigatorRight<CR>", { desc = "Navigate right" })

map("n", "<leader>gb", function()
  require("gitsigns").blame_line()
end, { desc = "Blame line" })
map("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "LazyGit" })

map("n", "<leader>fz", "<cmd>Telescope grep_string<CR>", { desc = "Grep under cursor" })
map("v", "<leader>fz", [[y<ESC>:Telescope live_grep default_text=<C-r>0<CR>]], { desc = "Live grep selection" })

map("n", "S", function()
  require("hop").hint_char2()
end, { desc = "Hop to 2-char target" })
map("n", "s", function()
  require("hop").hint_patterns({}, vim.fn.getreg "/")
end, { desc = "Hop using last search pattern" })
