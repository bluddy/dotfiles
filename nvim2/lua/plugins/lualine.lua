return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = function()
    require("user.plugin_config.lualine")
  end,
}