return {
  "tpope/vim-sleuth",
  "tversteeg/registers.nvim",

  {
    "chrisgrieser/nvim-early-retirement",
    config = true,
    event = "VeryLazy",
  },

  {
    "ojroques/nvim-bufdel",
    event = "VeryLazy",
  },

  {
    "mfussenegger/nvim-treehopper",
    keys = {
      { "m", ":<C-U>lua require('tsht').nodes()<CR>", mode = "o" },
      { "m", ":lua require('tsht').nodes()<CR>", mode = "v" },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "nvimtools/none-ls.nvim",
        dependencies = {
          "nvimtools/none-ls-extras.nvim",
          "gbprod/none-ls-shellcheck.nvim",
        },
        config = function()
          require "configs.none-ls"
        end,
      },
      { "j-hui/fidget.nvim", tag = "legacy", opts = {} },
      "folke/neodev.nvim",
    },
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/playground",
    cmd = "TSCaptureUnderCursor",
    config = function()
      require("nvim-treesitter.configs").setup {
        playground = {
          enable = true,
        },
      }
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = function()
      return require "configs.nvimtree"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      return require "configs.treesitter"
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-refactor",
      "hiphish/rainbow-delimiters.nvim",
      {
        "David-Kunz/treesitter-unit",
        keys = {
          { mode = "x", "iu", ':lua require"treesitter-unit".select()<CR>', desc = "Select in unit" },
          { mode = "x", "au", ':lua require"treesitter-unit".select(true)<CR>', desc = "Select around unit" },
          { mode = "o", "iu", ':<C-U>lua require"treesitter-unit".select()<CR>', desc = "Select in unit" },
          { mode = "o", "au", ':<C-U>lua require"treesitter-unit".select(true)<CR>', desc = "Select around unit" },
        },
      },
    },
  },

  {
    "mason-org/mason.nvim",
    opts = function()
      return require "configs.mason"
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {},
  },

  {
    "numToStr/Navigator.nvim",
    cmd = { "NavigatorLeft", "NavigatorRight", "NavigatorUp", "NavigatorDown" },
    config = function()
      require("Navigator").setup()
    end,
  },

  {
    "nmac427/guess-indent.nvim",
    event = "VeryLazy",
    config = function()
      require("guess-indent").setup()
    end,
  },

  {
    "ellisonleao/glow.nvim",
    cmd = "Glow",
    config = function()
      require("glow").setup {
        style = "dark",
        width = 120,
      }
    end,
  },

  {
    "melkster/modicator.nvim",
    event = "VeryLazy",
    dependencies = "nvchad/base46",
    init = function()
      vim.o.number = true
      vim.o.cursorline = true
      vim.o.termguicolors = true
    end,
    config = function()
      require("modicator").setup()
    end,
  },

  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    config = true,
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next todo comment",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous todo comment",
      },
      { "<leader>st", "<cmd>TodoTelescope<CR>", desc = "Todo" },
    },
  },

  {
    "nvim-zh/colorful-winsep.nvim",
    config = true,
    event = "WinNew",
  },

  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      local select = vim.ui.select
      local input = vim.ui.input

      vim.ui.select = function(...)
        require("lazy").load { plugins = { "dressing.nvim" } }
        return select(...)
      end

      vim.ui.input = function(...)
        require("lazy").load { plugins = { "dressing.nvim" } }
        return input(...)
      end
    end,
  },

  {
    "folke/zen-mode.nvim",
    config = true,
    event = "VeryLazy",
    keys = {
      {
        "<leader>zz",
        function()
          require("zen-mode").toggle()
          vim.wo.wrap = false
          vim.wo.number = true
          vim.wo.rnu = true
        end,
        desc = "Zen mode with numbers",
      },
      {
        "<leader>zZ",
        function()
          require("zen-mode").toggle()
          vim.wo.wrap = false
          vim.wo.number = false
          vim.wo.rnu = false
        end,
        desc = "Zen mode without numbers",
      },
    },
  },

  {
    "folke/twilight.nvim",
    keys = {
      { "<leader>wt", "<cmd>Twilight<CR>", desc = "Toggle Twilight" },
    },
    opts = { context = 12 },
  },

  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  {
    "machakann/vim-sandwich",
    event = "VeryLazy",
    keys = {
      { "sa", desc = "Add surrounding", mode = { "n", "v" } },
      { "sd", desc = "Delete surrounding" },
      { "sr", desc = "Replace surrounding" },
    },
  },

  {
    "phaazon/hop.nvim",
    branch = "v2",
    opts = { keys = "etovxqpdygfblzhckisuran" },
  },

  {
    "utilyre/sentiment.nvim",
    event = "BufReadPre",
    config = function()
      require("sentiment").setup()
    end,
  },

  {
    "Wansmer/treesj",
    keys = { "<space>m", "<space>j", "<space>s" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesj").setup()
    end,
  },

  {
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu",
  },

  {
    "jghauser/mkdir.nvim",
    event = { "FileWritePre", "BufWritePre" },
    config = function()
      require "mkdir"
    end,
  },

  {
    "ruifm/gitlinker.nvim",
    event = "BufRead",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      action_callback = function(url)
        vim.fn.setreg('"', url)

        if vim.fn.exists("*OSCYankString") == 1 then
          vim.fn.OSCYankString(url)
        else
          vim.fn.setreg("+", url)
        end
      end,
    },
  },

  {
    "akinsho/flutter-tools.nvim",
    ft = "dart",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    config = function()
      require("flutter-tools").setup()
    end,
  },

  {
    "chomosuke/term-edit.nvim",
    ft = "neoterm",
    version = "1.*",
    opts = {
      prompt_end = "❯ ",
    },
  },

  {
    "willothy/flatten.nvim",
    config = true,
    lazy = false,
    priority = 1001,
  },

  {
    "DanilaMihailov/beacon.nvim",
    cond = function()
      return not vim.g.neovide
    end,
    event = "WinEnter",
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
  },

  {
    "farmergreg/vim-lastplace",
    event = "BufReadPre",
  },

  {
    "monaqa/dial.nvim",
    keys = {
      {
        "<leader>di",
        function()
          return require("dial.map").inc_normal()
        end,
        expr = true,
      },
      {
        "<leader>dd",
        function()
          return require("dial.map").dec_normal()
        end,
        expr = true,
      },
      {
        "<leader>di",
        function()
          return require("dial.map").inc_visual()
        end,
        mode = "v",
        expr = true,
      },
      {
        "<leader>dd",
        function()
          return require("dial.map").dec_visual()
        end,
        mode = "v",
        expr = true,
      },
    },
    config = function()
      local augend = require "dial.augend"
      require("dial.config").augends:register_group {
        default = {
          augend.integer.alias.decimal,
          augend.constant.alias.bool,
          augend.constant.new {
            elements = { "True", "False" },
            word = true,
            cyclic = true,
          },
          augend.semver.alias.semver,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.new {
            elements = { "and", "or" },
            word = true,
            cyclic = true,
          },
          augend.constant.new {
            elements = { "&&", "||" },
            word = false,
            cyclic = true,
          },
        },
      }
    end,
  },
}
