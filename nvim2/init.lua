-- Disable LSP file watcher globally to fix the high CPU/statx loop on Linux
local ok, wf = pcall(require, "vim.lsp._watchfiles")
if ok then
  wf._watchfunc = function()
    return function() end
  end
end

require "config.lazy"



