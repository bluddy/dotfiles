return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  dependencies = { "kyazdani42/nvim-web-devicons" },
  config = function()
    require("user.plugin_config.bufferline")
  end,
}