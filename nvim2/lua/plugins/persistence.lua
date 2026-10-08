return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {
    -- Save even if only terminal/non-file buffers are open
    need = 0,
  },
  init = function()
    -- Automatically restore session on startup when launching `nvim` with no file args
    vim.api.nvim_create_autocmd("VimEnter", {
      group = vim.api.nvim_create_augroup("PersistenceAutoLoad", { clear = true }),
      nested = true,
      callback = function()
        -- Skip if Neovim was launched with file arguments or reading from stdin
        if vim.fn.argc() == 0 and not vim.g.started_with_stdin then
          require("persistence").load()
        end
      end,
    })
  end,
}
