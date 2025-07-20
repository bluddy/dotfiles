-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Configure lazy.nvim
require("lazy").setup({
  -- Core dependencies
  { "nvim-lua/plenary.nvim" }, -- Useful lua functions used by lots of plugins

  -- Autopairs
  { 
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("user.plugin_config.autopairs")
    end,
  },

  -- Comments
  { 
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("user.plugin_config.comment")
    end,
  },
  { "JoosepAlviste/nvim-ts-context-commentstring" },

  -- UI Components
  { "kyazdani42/nvim-web-devicons" },

  -- Bufferline
  { 
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("user.plugin_config.bufferline")
    end,
  },
  { "moll/vim-bbye" },

  -- Statusline
  { 
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("user.plugin_config.lualine")
    end,
  },

  -- Terminal
  { 
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    config = function()
      require("user.plugin_config.toggleterm")
    end,
  },

  -- Project management
  { 
    "ahmedkhalf/project.nvim",
    config = function()
      require("user.plugin_config.project")
    end,
  },

  -- Performance
  { 
    "lewis6991/impatient.nvim",
    config = function()
      require("user.plugin_config.impatient")
    end,
  },

  -- Dashboard
  { 
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      require("user.plugin_config.alpha")
    end,
  },

  -- Surround
  { 
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end
  },

  -- Colorschemes
  { 
    "ishan9299/nvim-solarized-lua",
    priority = 1000,
    config = function()
      require("user.plugin_config.colorscheme")
    end,
  },

  -- Completion
  { 
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",   -- buffer completions
      "hrsh7th/cmp-path",     -- path completions
      "saadparwaiz1/cmp_luasnip", -- snippet completions
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "L3MON4D3/LuaSnip",     -- snippet engine
      "rafamadriz/friendly-snippets", -- a bunch of snippets to use
    },
    config = function()
      require("user.plugin_config.cmp")
    end,
  },

  -- LSP
  { 
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      require("user.lsp")
    end,
  },
  { 
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("user.plugin_config.illuminate")
    end,
  },

  -- Telescope
  { 
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("user.plugin_config.telescope")
    end,
  },

  -- Treesitter
  { 
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
      require("user.plugin_config.treesitter")
    end,
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    config = function()
      require("user.plugin_config.indentline")
    end,
  },

  -- Git
  { 
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("user.plugin_config.gitsigns")
    end,
  },
  { "jreybert/vimagit", cmd = "Magit" },

  -- Debug Adapter Protocol
  { 
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "ravenxrz/DAPInstall.nvim",
    },
    config = function()
      require("user.plugin_config.dap")
    end,
  },

  -- Which Key
  { 
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  },

  -- Oil file manager
  {
    "stevearc/oil.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("oil").setup()
    end,
  },

  -- VimWiki
  { 
    "vimwiki/vimwiki",
    event = "VeryLazy",
    init = function()
      -- This runs before the plugin is loaded
      vim.g.vimwiki_list = {{path='~/wiki/'}}
    end,
  },

  -- Git tools
  { 
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  { 
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = true
  },
}, {
  -- Lazy.nvim configuration options
  ui = {
    border = "rounded",
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- LSP configuration that was inline in the original file
require'lspconfig'.ocamllsp.setup{}
