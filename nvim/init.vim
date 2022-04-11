set nocompatible | filetype indent plugin on | syn on
set hidden          " Allow buffers to go into the background

runtime ./plug.vim

" For keeping info between sessions
set viminfo='500,f1,<500,:500,@500,/500

set nocompatible " vim rather than vi settings
set autoread " Update automatically on file change

set t_Co=256

"colorscheme solarized
"let g:solarized_termcolors=256
"let g:solarized_visibility="high"
"let g:solarized_contrast="high"
set termguicolors
set background=light
colorscheme solarized

set shiftwidth=2
set tabstop=2
set expandtab

" Don't save a backup
set nobackup
set nowritebackup

set gdefault   " regex defaults to g

" Set ignorecase on
set ignorecase
set smartcase

set cursorline
set ruler

" Line numbers
set nu

" Show matching brackets
set showmatch

" Wrap all keys including backspace
set whichwrap=b,s,h,l,<,>,[,]

set clipboard^=unnamed,unnamedplus

" Prevent breaking up of lines
set textwidth=0 wrapmargin=0

" Visual wrapping enabled
set wrap

" Command completion more useful
set wildmenu " Show many options
set wildmode=longest:full,full  " Complete up to point of ambiguity

" Show window title
set title

set visualbell          " don't beep
set noerrorbells        " don't beep

set virtualedit=block  " Make block editing better

" Make paste mode easy
set pastetoggle=<F2>

" Make status line appear on one window
set ls=2

" Make Ctrl-P and others not search certain files
set wildignore+=*.cmi,*.cmo,*.cmt,*.cmti,*.cmx,*.annot,*.orig,*.swp,*.o,*/bin/*,_build/*

" Make vim batch screen updates
set lazyredraw

" Add <> to matched pairs
set matchpairs+=<:>

highlight DiffText ctermbg=LightBlue

" Replace Wq with wq etc
if has("user_commands")
    command! -bang -nargs=? -complete=file E e<bang> <args>
    command! -bang -nargs=? -complete=file W w<bang> <args>
    command! -bang -nargs=? -complete=file Wq wq<bang> <args>
    command! -bang -nargs=? -complete=file WQ wq<bang> <args>
    command! -bang Wa wa<bang>
    command! -bang WA wa<bang>
    command! -bang Q q<bang>
    command! -bang QA qa<bang>
    command! -bang Qa qa<bang>
    command! RemoveTrailing call RemoveTrailing()
endif

" Grep sometimes doesn't display a filename
set grepprg=grep\ -nH\ $*

" Sessions: don't save some things
set ssop-=options
set ssop-=folds

set inccommand=split

set completeopt=menu,menuone,noselect

if has("autocmd")
  augroup languages
    autocmd!
    autocmd BufNewFile,BufRead *.eliom,*.eliomi set filetype=ocaml
    autocmd BufNewFile,BufRead *.cppmd set filetype=markdown
    autocmd FileType markdown nnoremap <buffer> <LocalLeader>p o<CR>\pause<CR><Esc>
    autocmd FileType haskell setlocal tabstop=2 expandtab softtabstop=2
        \ shiftwidth=2 smarttab shiftround nojoinspaces
    autocmd FileType ocaml setlocal tabstop=2 expandtab softtabstop=2
        \ shiftwidth=2 smarttab shiftround nojoinspaces
    autocmd FileType cpp,c setlocal tabstop=2 expandtab softtabstop=2
        \ shiftwidth=2
        \ | nnoremap <silent> <LocalLeader>a :<C-u>A<CR>
    autocmd FileType python setlocal tabstop=4 expandtab softtabstop=4
        \ shiftwidth=4 smarttab shiftround nojoinspaces
    " Make sure quickfix always opens at the bottom
    autocmd FileType qf wincmd J
        autocmd BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl
    " Add the tex dictionary
    autocmd FileType tex execute 'setlocal dict+=~/.vim/words/'.&filetype.'.txt'
  augroup END
  augroup fugitive
    autocmd!
        " Allow .. instead of :edit %:h when browsing in fugitive (git) trees
    autocmd User fugitive if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' | nnoremap <buffer> .. :edit %:h<CR> | endif
    " Don't flood open buffers with fugitive files
    autocmd BufReadPost fugitive://* set bufhidden=delete
  augroup END
  augroup highlight
    autocmd!
    " Remove search highlighting for insert mode
    autocmd InsertEnter * :setlocal nohlsearch
    autocmd InsertLeave * :setlocal hlsearch
  augroup END
  " augroup relative
  "   autocmd!
  "   autocmd InsertEnter * call NumberIfPresent('n')
  "   autocmd InsertLeave * call NumberIfPresent('r')
  "   autocmd WinEnter * call NumberIfPresent('r')
  "   autocmd WinLeave * call NumberIfPresent('n')
  "   autocmd FocusGained * call NumberIfPresent('r')
  "   autocmd FocusLost * call NumberIfPresent('n')
  "   autocmd CursorMoved * call NumberIfPresent('r')
  " augroup END
  " For OCaml
  augroup PostPlugins
    autocmd!
    autocmd VimEnter *
        \ highlight EnclosingExpr ctermbg=Red
  augroup END
  " Hide preview after completion or when leaving insert.
  "autocmd! Preview autocmd InsertLeave * silent! pclose!
endif

" ----------------- Remaps ---------------------
"
" Better leader
nnoremap <SPACE> <Nop>
let mapleader = "\<SPACE>"
let maplocalleader = ","

" Make n always search forward
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]

" Map jk to esc
inoremap jk <Esc>
" Map x so it doesn't record (we don't need single characters in registers)
nnoremap x "_x
nnoremap X "_X
nnoremap Y y$
" Prevent ex mode from Q
nnoremap Q <nop>

" Make going down/up long lines easier
nnoremap <silent> j :<C-U>call JkJumps('j')<CR>
nnoremap <silent> k :<C-U>call JkJumps('k')<CR>
nnoremap gj j
nnoremap gk k

" Make entering a : take away relative numbering
" nnoremap : :<C-U>call NumberIfPresent('n')<CR>:

" clear highlights
nnoremap <silent> <leader>n :silent :nohlsearch<CR>

" Make moving around windows easier
" Turn off stupid bash support
let g:BASH_Ctrl_j = 'off'

" Allow C-p and C-n to filter command line
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Fix the & command (repeat subst with flags)
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" QuickFix toggle
nnoremap <silent> <leader>q :call QuickFixToggle()<cr>
let g:quickfix_is_open = 0

" toggle quickfix window
function! QuickFixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endf
" }}}

" Turn big j/k jumps into proper jumps {{{
if !exists('g:jk_jumps_minimum_lines')
    let g:jk_jumps_minimum_lines = 3
endif

function! JkJumps(key) range
    " For 1 line, add g for display lines
    if v:count1 <= 1
        exec "normal! ".v:count1."g".a:key
    elseif v:count1 < g:jk_jumps_minimum_lines
        exec "normal! ".v:count1.a:key
    else
        exec "normal! ".v:count1.a:key
        let target = line('.')
        let bkey = 'k'
        if (a:key ==# 'k')
            let bkey = 'j'
        endif
        exec "normal! ".v:count1.bkey
        exec "normal! ".target."G"
    endif
endfunction

" function! NumberIfPresent(m)
"     if(&relativenumber == 1 || &number == 1)
"         if(a:m ==# 'n')
"             set number
"         else
"             set relativenumber
"         endif
"     endif
" endfunction
" }}}

function! RemoveTrailing()
  %s/\s\+$//e
endfunction

" For latex
let g:tex_flavor='latex' " Get vim to label the file properly

" Edit config quickly
nnoremap <Leader>zz :<C-U>e ~/.config/nvim/init.vim<CR>
nnoremap <Leader>zg :<C-U>e ~/.config/nvim/plug.vim<CR>

function! DiffToggle()
  if &diff
    diffoff
  else
    diffthis
  endif
endfunction

nnoremap <silent> <Leader>df :<C-U>call DiffToggle()<CR>

" ----------- Variable settings for plugins --------------

" Get rid of mapping of signature so 0 is fast
if mapcheck("0m?", "n")
  nunmap 0m?
endif

" Startify bookmarks
let g:startify_bookmarks = ['~/.config/nvim/init.vim', '~/.zshrc']

" Make vimwiki use Google Drive
let g:vimwiki_list = [{'path': '~/gdrive/wiki/vimwiki/'}]

" NERDTree
let NERDTreeIgnore=[ '\.cmo$[[file]]', '\.o$[[file]]', '\.cmi$[[file]]'
                  \, '\.cmx$[[file]]', '\.cmt$[[file]]', '\.cmti$[[file]]'
                  \, '\.pyc$[[file]]', '\.a$[[file]]'
                  \]

" Make vimfiler the default file explorer
let g:vimfiler_as_default_explorer = 1

" Grepper
"nmap gs <plug>(GrepperOperator)

"xmap gs <plug>(GrepperOperator)
"nnoremap <leader>gg :<C-U>Grepper -tool git<CR>
"nnoremap <leader>ga :<C-U>Grepper -tool ag<CR>
"nnoremap <leader>gs :<C-U>Grepper -tool ag -side<CR>
"nnoremap <leader>* :<C-U>Grepper -tool ag -cword -noprompt<CR>

" vim-slime
let g:slime_target = "tmux"

" Terminal
tnoremap <Esc> <C-\><C-n>
tnoremap jk <C-\><C-n>
tnoremap <C-v><Esc> <Esc>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-v><C-h> <C-h>
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-v><C-j> <C-j>
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-v><C-k> <C-k>
tnoremap <C-l> <C-\><C-n><C-w>l
tnoremap <C-v><C-l> <C-l>

" Good bindings for debugger
let g:vimspector_enable_mappings = 'HUMAN'

let s:off = match(system('uname -a'), 'Microsoft')
if s:off != -1
  " Support WSL
  let g:clipboard = {
    \   'name': 'WslClipboard',
    \   'copy': {
    \      '+': 'clip.exe',
    \      '*': 'clip.exe',
    \    },
    \   'paste': {
    \      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    \      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    \   },
    \   'cache_enabled': 0,
    \ }
endif

" lua require"surround".setup{} " Not ready for prime time

" Use LSP
":lua << EOF
"  require'nvim_lsp'.pyls.setup{}
"EOF


