return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      refresh = {
        statusline = 100,  -- Refresh statusline components every 100ms when scrolling/active
        tabline = 100,
        winbar = 100,
        refresh_time = 1000, -- Check for background updates every 1000ms when idle
      }
    }
  }
}
