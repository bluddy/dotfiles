return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    require("user.plugin_config.autopairs")
  end,
}