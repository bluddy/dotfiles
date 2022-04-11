" CtrlP calls fzf :Buffers and :Files
nnoremap <C-P> :<C-U>Files<CR>
nnoremap <C-P><C-P> :<C-U>Buffers<CR>
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
