local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
  git = {
    clone_timeout = 300, -- Timeout, in seconds, for git clones
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use { "wbthomason/packer.nvim"} -- Have packer manage itself
  use { "nvim-lua/plenary.nvim"} -- Useful lua functions used by lots of plugins
  use { "windwp/nvim-autopairs"} -- Autopairs, integrates with both cmp and treesitter
  use { "numToStr/Comment.nvim"}
  use { "JoosepAlviste/nvim-ts-context-commentstring" }
  use { "kyazdani42/nvim-web-devicons" }
  -- use { "kyazdani42/nvim-tree.lua"}
  use { "akinsho/bufferline.nvim"}
  use { "moll/vim-bbye"}
  use { "nvim-lualine/lualine.nvim"}
  use { "akinsho/toggleterm.nvim"}
  use { "ahmedkhalf/project.nvim"}
  use { "lewis6991/impatient.nvim"}
  use { "goolord/alpha-nvim"}
  use ({ "kylechui/nvim-surround",
        config = function()
          require("nvim-surround").setup({})
        end
  })

  -- Colorschemes
  use { "ishan9299/nvim-solarized-lua"}

  -- cmp plugins
  use { "hrsh7th/nvim-cmp"} -- The completion plugin
  use { "hrsh7th/cmp-buffer"} -- buffer completions
  use { "hrsh7th/cmp-path"} -- path completions
  use { "saadparwaiz1/cmp_luasnip"} -- snippet completions
  use { "hrsh7th/cmp-nvim-lsp"}
  use { "hrsh7th/cmp-nvim-lua"}

  -- snippets
  use { "L3MON4D3/LuaSnip"} --snippet engine
  use { "rafamadriz/friendly-snippets"} -- a bunch of snippets to use

  -- LSP
  use { "neovim/nvim-lspconfig"} -- enable LSP
  use { "mason-org/mason.nvim" }
  use { "mason-org/mason-lspconfig.nvim" }
  use { "RRethy/vim-illuminate" }

  -- Telescope
  use { "nvim-telescope/telescope.nvim"}

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter" }

  -- Git
  use { "lewis6991/gitsigns.nvim"}
  use { "jreybert/vimagit" }

  -- DA
  use { "mfussenegger/nvim-dap" }
  use { "rcarriga/nvim-dap-ui" }
  use { "ravenxrz/DAPInstall.nvim" }
  -- Lua
  use {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
     }
    end
  }
  -- OCaml
  require'lspconfig'.ocamllsp.setup{}

  -- Oil
  use({
      "stevearc/oil.nvim",
      config = function()
        require("oil").setup()
      end,
    })

  use { "vimwiki/vimwiki" }

  use { "sindrets/diffview.nvim"}

  use { "NeogitOrg/neogit"}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
