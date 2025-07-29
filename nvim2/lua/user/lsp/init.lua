local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

-- OCaml
require'lspconfig'.ocamllsp.setup({
  cmd = {os.getenv("HOME") ..  "/.opam/default/bin/ocamllsp"},
})

require "user.lsp.mason"
require("user.lsp.handlers").setup()
require "user.lsp.null-ls"
