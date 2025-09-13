return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    local npairs = require "nvim-autopairs"
    local Rule = require "nvim-autopairs.rule"

    npairs.setup {}

    require("nvim-autopairs").get_rules("`")[1].not_filetypes = { "ocaml" }
  end,
}
