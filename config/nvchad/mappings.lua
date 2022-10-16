local M = {}

M.general = {
  n = {
    [";"] = { ":", "command mode", opts = { nowait = true } },
  },

  i = {
    ["jk"] = { "<ESC>", "escape vim" },
  },
}

M.truzen = {
  n = {
    ["<leader>ta"] = { "<cmd> TZAtaraxis <CR>", "   truzen ataraxis" },
    ["<leader>tm"] = { "<cmd> TZMinimalist <CR>", "   truzen minimal" },
    ["<leader>tf"] = { "<cmd> TZFocus <CR>", "   truzen focus" },
  },
}

M.treesitter = {
  n = {
    ["<leader>cu"] = { "<cmd> TSCaptureUnderCursor <CR>", "  find media" },
  },
}

M.lazygit = {
  n = {
    ["<leader>lz"] = {
      function()
        require("nvterm.terminal").send("lazygit", "vertical")
      end,
      "nvterm lazygit",
    },
  },
}

M.navigation = {
  n = {
    ["H"] = { "^", "beginning of line" },
    ["L"] = { "$", "end of line" },
    ["<C-h>"] = {
      ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateLeft()<cr>",
      "tmux navigate left",
    },
    ["<C-j>"] = {
      ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateDown()<cr>",
      "tmux navigate down",
    },
    ["<C-k>"] = {
      ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateUp()<cr>",
      "tmux navigate up",
    },
    ["<C-l>"] = {
      ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateRight()<cr>",
      "tmux navigate right",
    },
  },
}

return M
