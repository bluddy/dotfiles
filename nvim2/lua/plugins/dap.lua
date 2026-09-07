return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio", -- required by nvim-dap-ui
      "ravenxrz/DAPInstall.nvim",
      {
        "mfussenegger/nvim-dap-python",
        ft = "python",
      },
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end, desc = "Conditional Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue / Start" },
      { "<F5>", function() require("dap").continue() end, desc = "Continue / Start" },
      { "<F10>", function() require("dap").step_over() end, desc = "Step Over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Step Into" },
      { "<F12>", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      -- Python-specific: debug nearest test / method
      { "<leader>dn", function() require("dap-python").test_method() end, desc = "Debug Test Method", ft = "python" },
      { "<leader>df", function() require("dap-python").test_class() end, desc = "Debug Test Class", ft = "python" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Shared debugpy interpreter (installed once, used across projects).
      local debugpy_python
      if vim.fn.has("win32") == 1 then
        debugpy_python = vim.fn.expand("$LOCALAPPDATA") .. "\\nvim-debugpy\\Scripts\\python.exe"
      else
        debugpy_python = vim.fn.expand("~/.local/share/nvim-debugpy/bin/python")
      end

      require("dap-python").setup(debugpy_python)

      -- Resolve the interpreter that should RUN the debugged code:
      -- prefer an activated venv, else a `venv`/`.venv` in the cwd, else the debugpy one.
      local function project_python()
        local venv = os.getenv("VIRTUAL_ENV")
        if venv then
          local p = venv .. (vim.fn.has("win32") == 1 and "\\Scripts\\python.exe" or "/bin/python")
          if vim.fn.executable(p) == 1 then return p end
        end
        local cwd = vim.fn.getcwd()
        local candidates = vim.fn.has("win32") == 1
          and { cwd .. "\\venv\\Scripts\\python.exe", cwd .. "\\.venv\\Scripts\\python.exe" }
          or { cwd .. "/venv/bin/python", cwd .. "/.venv/bin/python" }
        for _, p in ipairs(candidates) do
          if vim.fn.executable(p) == 1 then return p end
        end
        return debugpy_python
      end

      -- Make dap-python use the project interpreter for launched programs.
      dap.configurations.python = dap.configurations.python or {}
      table.insert(dap.configurations.python, 1, {
        type = "python",
        request = "launch",
        name = "Launch file (project venv)",
        program = "${file}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        pythonPath = project_python,
      })

      -- Load VSCode launch.json profiles so existing configs are debuggable.
      -- nvim-dap's built-in parser is strict JSON and rejects the // comments and
      -- trailing commas that VSCode tolerates, so we sanitize to a temp file first
      -- and hand that to load_launchjs.
      local function load_vscode_launch()
        local path = vim.fn.getcwd() .. "/.vscode/launch.json"
        if vim.fn.filereadable(path) == 0 then return end

        local raw = table.concat(vim.fn.readfile(path), "\n")
        -- Strip // line comments (not inside strings) and /* */ block comments.
        raw = raw:gsub("/%*.-%*/", "")
        local cleaned = {}
        for line in (raw .. "\n"):gmatch("(.-)\n") do
          local in_str, esc, cut = false, false, nil
          for i = 1, #line do
            local c = line:sub(i, i)
            if in_str then
              if esc then esc = false
              elseif c == "\\" then esc = true
              elseif c == '"' then in_str = false end
            elseif c == '"' then in_str = true
            elseif c == "/" and line:sub(i + 1, i + 1) == "/" then cut = i - 1; break end
          end
          table.insert(cleaned, cut and line:sub(1, cut) or line)
        end
        raw = table.concat(cleaned, "\n")
        -- Remove trailing commas before } or ].
        raw = raw:gsub(",%s*([%]}])", "%1")

        local tmp = vim.fn.tempname() .. ".json"
        vim.fn.writefile(vim.split(raw, "\n"), tmp)

        local ok_v, vscode = pcall(require, "dap.ext.vscode")
        if not ok_v then return end
        local ok_l, err = pcall(vscode.load_launchjs, tmp, { debugpy = { "python" }, python = { "python" } })
        if not ok_l then
          vim.notify("Failed to load launch.json: " .. tostring(err), vim.log.levels.WARN)
        end
        pcall(os.remove, tmp)
      end

      load_vscode_launch()
      -- Reload profiles whenever you change directory into another project.
      vim.api.nvim_create_autocmd("DirChanged", { callback = load_vscode_launch })

      -- Auto-open/close the DAP UI around sessions.
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

      -- Breakpoint sign.
      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticWarn", linehl = "Visual", numhl = "" })
    end,
  },
}
