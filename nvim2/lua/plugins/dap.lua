return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "ravenxrz/DAPInstall.nvim",
  },
  config = function()
    require("user.plugin_config.dap")
  end,
}