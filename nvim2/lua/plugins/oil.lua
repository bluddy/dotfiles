return {
  "stevearc/oil.nvim",
  dependencies = { "kyazdani42/nvim-web-devicons" },
  config = function()
    require("oil").setup()
  end,
}