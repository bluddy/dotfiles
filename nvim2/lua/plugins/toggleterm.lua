return {
  "akinsho/toggleterm.nvim",
  cmd = {
    "ToggleTerm",
    "TermExec",
    "ToggleTermSendCurrentLine",
    "ToggleTermSendVisualSelection",
    "ToggleTermSendVisualLines",
  },
  keys = {
    { [[<C-\>]], "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
    { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
    { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle floating terminal" },
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle horizontal terminal" },
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<cr>", desc = "Toggle vertical terminal" },
    -- Send text to the terminal.
    { "<leader>ts", "<cmd>ToggleTermSendCurrentLine<cr>", mode = "n", desc = "Send current line to terminal" },
    { "<leader>ts", "<cmd>ToggleTermSendVisualSelection<cr>", mode = "x", desc = "Send selection to terminal" },
    { "<leader>tS", "<cmd>ToggleTermSendVisualLines<cr>", mode = "x", desc = "Send selected lines to terminal" },
  },
  opts = {
    -- <C-\> also toggles from inside the terminal.
    open_mapping = [[<C-\>]],
    direction = "float",
    float_opts = { border = "curved" },
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return math.floor(vim.o.columns * 0.4)
      end
    end,
    -- Start terminals in insert mode and keep them out of the buffer list.
    start_in_insert = true,
    persist_mode = false,
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)

    -- Terminal-mode navigation inside toggleterm buffers (buffer-local),
    -- so <Esc> and <C-hjkl> behave like they do in a normal :terminal.
    local function set_terminal_keymaps()
      local map_opts = { buffer = 0, silent = true }
      vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], map_opts)
      vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], map_opts)
      vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], map_opts)
      vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], map_opts)
      vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], map_opts)
    end

    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "term://*toggleterm#*",
      callback = set_terminal_keymaps,
    })
  end,
}
