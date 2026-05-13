return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

 -- test new blink
  { import = "nvchad.blink.lazyspec" },

  -- show dotfiles and .gitignore files
  {
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
      require "configs.telescope"
    end,
  },

  -- surround
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
  },

  -- zoxide with telescope
  {
    "jvgrootveld/telescope-zoxide",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("zoxide")
    end,
  },

  -- faster navigation
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
  },

  -- treesitter fix
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   branch = "main", -- Force the new rewrite branch
  --   build = ":TSUpdate",
  --     opts = {
  --       ensure_installed = {
  --         "vim", "lua", "vimdoc",
  --          "html", "css"
  --       },
  --   },
  -- },

  -- nvim-tree override to show dotfiles and .gitignore files
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require "configs.nvimtree"
    end,
  },

  -- git interface for neovim
  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional
      "m00qek/baleia.nvim",            -- optional
      "nvim-telescope/telescope.nvim", -- optional
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
    },
  },

  -- Detect tabstop and shiftwidth automatically
  {
    'tpope/vim-sleuth',
    lazy = false
  },

  -- Save vim session in a Session.vim file 
  {
    'tpope/vim-obsession',
    lazy = false
  },

  -- split or join arrays and objects
  {
    'Wansmer/treesj',
    keys = {
      { '<leader>S', function()
        require('treesj').split()
      end, desc = "Split (TreeSJ)" },
      { '<leader>J', function() require('treesj').join() end, desc = "Join (TreeSJ)" },
    },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesj').setup({
        use_default_keymaps = false,
        recursive = false,
      })
    end,
  },

  -- highlight todos
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  -- preview markdown files
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { "markdown" },
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render_markdown.Config
    opts = {},
  }
}
