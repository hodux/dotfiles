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

  -- telescope ovverride to show dotfiles and .gitignore files
  {
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
      require("telescope").setup({
        pickers = {
          find_files = {
            find_command = {'rg', '--files', '--hidden', '-g', '!.git'},
          },
        },
      })
    end,
  },

  -- surround with ysiw
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
          -- Configuration here, or leave empty for defaults
      })
    end,
  },

  -- zoxide inside nvim
  {
    "jvgrootveld/telescope-zoxide",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("zoxide")
    end,
  },

  -- jump inside nvim
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
  },

  -- treesitter
  {
  	"nvim-treesitter/nvim-treesitter",
    branch = "main", -- Force the new rewrite branch
    build = ":TSUpdate",
  	opts = {
  		ensure_installed = {
  			"vim", "lua", "vimdoc",
       "html", "css"
  		},
  	},
  },

  -- nvim-tree override to show dotfiles and .gitignore files
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        filters = {
          --- display dot files in file explorer, hopefully
          dotfiles = false,
          git_ignored = false,
        },
        git = {
          ignore = false,
        },
      })
    end,
  },

  -- git interface for neovim
  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required

      "sindrets/diffview.nvim",        -- optional

      -- For a custom log pager
      "m00qek/baleia.nvim",            -- optional

      -- Only one of these is needed.
      "nvim-telescope/telescope.nvim", -- optional
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
    },
  },

  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

}
