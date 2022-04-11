" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <leader>* <cmd>Telescope grep_string<cr>

" LSP
nnoremap <leader>ls <cmd>Telescope lsp_document_symbols<cr>
nnoremap <leader>la <cmd>Telescope lsp_code_actions<cr>
nnoremap <leader>li <cmd>Telescope lsp_implementations<cr>
nnoremap <leader>lt <cmd>Telescope lsp_type_definitions<cr>
nnoremap <leader>ld <cmd>Telescope lsp_definitions<cr>

" Git
nnoremap <leader>gs <cmd>Telescope git_status<cr>
nnoremap <leader>gc <cmd>Telescope git_commits<cr>
nnoremap <leader>gf <cmd>Telescope git_bcommits<cr>
nnoremap <leader>gb <cmd>Telescope git_branches<cr>

