return {
  "folke/noice.nvim",
  opts = function(_, opts)
    -- Monkey-patch noice.message.router enable function to only run the interval timer
    -- when there are active/pending updates, completely silencing the unconditional
    -- 33ms (30 FPS) background polling loop when idle. We keep a 1-second grace period
    -- after the last update to allow all animations and deferred view actions to complete.
    local original_require = require
    rawset(_G, "require", function(name)
      if name == "noice.message.router" then
        rawset(_G, "require", original_require) -- Restore require immediately once intercepted
        local router = original_require(name)
        router.enable = function()
          if not router._updater then
            local Manager = require("noice.message.manager")
            local Util = require("noice.util")
            local Config = require("noice.config")
            
            local last_manager_tick = -1
            local grace_until = 0
            
            router._updater = Util.interval(Config.options.throttle, Util.protect(router.update), {
              enabled = function()
                local current_tick = Manager.tick()
                if current_tick ~= last_manager_tick then
                  last_manager_tick = current_tick
                  grace_until = vim.uv.now() + 1000
                end
                return vim.uv.now() < grace_until
              end
            })

            -- Since the updater timer can now stop itself when idle, we must restart it
            -- whenever new messages or UI events are registered in the Manager.
            local original_add = Manager.add
            Manager.add = function(...)
              local res = original_add(...)
              router._updater()
              return res
            end

            local original_remove = Manager.remove
            Manager.remove = function(...)
              local res = original_remove(...)
              router._updater()
              return res
            end

            local original_clear = Manager.clear
            Manager.clear = function(...)
              local res = original_clear(...)
              router._updater()
              return res
            end
          end
          router._updater()
        end
        return router
      end
      return original_require(name)
    end)

    return opts
  end,
}
