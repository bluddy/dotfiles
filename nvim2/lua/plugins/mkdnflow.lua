return {
  "jakewvincent/mkdnflow.nvim",
  config = function()
    require("mkdnflow").setup({
      dirs = { "~/wiki" },

    })
  end,
  ft = "markdown",
}