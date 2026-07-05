return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = function()
    -- Monkey-patch which-key to eliminate the unconditional 50ms polling timer.
    -- This timer is a workaround for older Neovim versions where ModeChanged was unreliable.
    -- On Neovim 0.12+, ModeChanged triggers perfectly and this loop is redundant.
    local state = require("which-key.state")
    local original_setup = state.setup
    state.setup = function(...)
      local t = vim.uv.new_timer()
      local mt = getmetatable(t)
      local original_start = mt.__index.start
      mt.__index.start = function(self, timeout, repeat_ms, callback)
        if repeat_ms == 50 then
          -- Disable the 50ms polling hack
          return 0
        end
        return original_start(self, timeout, repeat_ms, callback)
      end

      original_setup(...)

      mt.__index.start = original_start
      t:close()
    end

    require("which-key").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  end
}