set nocompatible | filetype indent plugin on | syn on
set hidden          " Allow buffers to go into the background

fun! SetupPlug()
  let root_dir = expand('$HOME', 1) . '/.local/share/nvim/site'
  if !filereadable(root_dir . '/autoload/plug.vim')
    execute '!curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  endif
endfun

call SetupPlug()

call plug#begin('~/.local/share/nvim/plugged')

Plug 'sjl/gundo.vim'     " Undo graph
Plug 'tmhedberg/matchit' " Match brackets
"Plug 'andymass/vim-matchup' " Modern matchit
"Plug 'ctrlpvim/ctrlp.vim'        " Fuzzy file matching (replaced by fzf)
Plug 'tpope/vim-abolish' " Easy, simple regex substitutes
Plug 'tpope/vim-surround' " Manipulate parentheses/quotes
Plug 'tpope/vim-unimpaired' " Bracket mappings
Plug 'tpope/vim-repeat'     " Repeat keys
Plug 'tpope/vim-vinegar'    " Enhances using netrw in a window
Plug 'tpope/vim-sleuth'    " Detect file settings
Plug 'tpope/vim-eunuch'    " Unix commands
Plug 'tpope/vim-fugitive'       " Git helper
Plug 'int3/vim-extradite'       " Git: view commit tree :Extradite
Plug 'junegunn/gv.vim'          " Git: :GV :GV! commit browser
Plug 'scrooloose/nerdtree'
"Plug 'scrooloose/syntastic' " Syntax checking (replaced by ALE)
Plug 'godlygeek/tabular' " Aligning tables
Plug 'kshenoy/vim-signature'   " Display marks
Plug 'bling/vim-airline'       " Status line
Plug 'kana/vim-textobj-lastpat'
Plug 'kana/vim-textobj-user'   " User defined text objects
Plug 'kana/vim-textobj-syntax' " Syntax highlighted items
Plug 'kana/vim-textobj-line'
Plug 'bronson/vim-visual-star-search' " Search from a visual pattern
Plug 'mhinz/vim-startify'      " Nice opening screen
Plug 'chrisbra/NrrwRgn'        " Narrow region like emacs
Plug 'MarcWeber/vim-addon-mw-utils'     " Needed for snipmate
Plug 'tomtom/tlib_vim'         " Needed for snipmate
Plug 'garbas/vim-snipmate'     " Snippets for snipmate (not working great!)
Plug 'honza/vim-snippets'
Plug 'def-lkb/vimbufsync'      " Heuristics to identify buffer changes
Plug 'justinmk/vim-sneak'      " Quick two-char searching; also replaces easymotion
Plug 'wellle/targets.vim'      " More text objects
Plug 'Peeja/vim-cdo'           " Allows operations over entire quicklist
Plug 'tomtom/tcomment_vim'      " Automatic commenting
Plug 'vimwiki/vimwiki'         " Wiki in vim
Plug 'mhinz/vim-signify'  " Show git changes in side
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-peekaboo'   " Show register contents
Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
Plug 'coderifous/textobj-word-column.vim' " Column text object
Plug 'Shougo/denite.nvim'        " Menu interface
"Plug 'tsukkee/denite-tag'       " Tags for Denite
"Plug 'Shougo/neomru.vim'       " MRU for Denite
Plug 'christoomey/vim-tmux-navigator' " Move around tmux
Plug 'mhinz/vim-grepper'       " Asynchronous search with ag etc
Plug 'osyo-manga/vim-monster', { 'for': 'ruby' }  " Ruby completion (requires rcodetools & vimproc)
"Plug 'def-lkb/ocp-indent-vim', { 'for': 'ocaml' } " Indentation for ocaml
Plug 'jreybert/vimagit'        " Cool interface for git
Plug 'rhysd/git-messenger.vim' " Explore commit messages per line
Plug 'lervag/vimtex'           " Advanced latex plugin
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'Shougo/deoplete.nvim', { 'do' : ':UpdateRemotePlugins' } " Completion
"Plug 'zchee/deoplete-jedi', { 'for': 'python' }     " Python completion
"Plug 'fishbullet/deoplete-ruby', { 'for': 'ruby'}   " Ruby completion
"Plug 'zchee/deoplete-clang', { 'for': 'c++'}        " C++ completion
Plug 'Shougo/deoplete-lsp' " LSP plugin
Plug 'copy/deoplete-ocaml' " Deoplete plugin for merlin
Plug 'metakirby5/codi.vim'     " Coding scratchpad
Plug 'tpope/vim-obsession'  " Auto vim session saving
Plug 'jpalardy/vim-slime'   " Copy to tmux
Plug 'hardenedapple/vsh'    " Modifiable shell windows
Plug 'roxma/vim-tmux-clipboard' " Integrate vim and tmux clipboards
Plug 'frankier/neovim-colors-solarized-truecolor-only'
Plug 'rgrinberg/vim-ocaml'  " Ocaml runtime syntax higlighting
Plug 'w0rp/ale' " Asynchronous lint engine
Plug 'nacitar/a.vim' " Switch between related files
Plug 'Shougo/vimproc.vim', {'do' : 'make'} " Needed for vebugger
Plug 'idanarye/vim-vebugger' " Vim debugger
Plug 'samoshkin/vim-mergetool'
Plug 'regedarek/ZoomWin' " C-w o to zoom in/out
Plug 'sbdchd/neoformat' " Formatting tool :Neoformat, can do ocp-indent
Plug 'nvim-treesitter/nvim-treesitter' " Treesitter (TInstall)
Plug 'neovim/nvim-lsp' " LSP default configurations

call plug#end()

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
highlight airline_x_to_airline_y_inactive ctermfg=LightGreen

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
        \ | nnoremap <silent><buffer> <LocalLeader>l :<C-u>MerlinLocate<CR>
        \ | nnoremap <silent><buffer> <LocalLeader>o :<C-u>MerlinOccurrences<CR>
        \ | nnoremap <silent><buffer> <LocalLeader>a :<C-u>A<CR>
        \ | map  <silent><buffer> <LocalLeader>t :<C-u>MerlinTypeOf<CR>
        \ | vmap <silent><buffer> <LocalLeader>t :<C-u>MerlinTypeOfSel<CR>
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
  augroup relative
    autocmd!
    autocmd InsertEnter * call NumberIfPresent('n')
    autocmd InsertLeave * call NumberIfPresent('r')
    autocmd WinEnter * call NumberIfPresent('r')
    autocmd WinLeave * call NumberIfPresent('n')
    autocmd FocusGained * call NumberIfPresent('r')
    autocmd FocusLost * call NumberIfPresent('n')
    autocmd CursorMoved * call NumberIfPresent('r')
  augroup END
  " Settings for denite
  augroup DeniteInit
    autocmd!
    autocmd FileType denite call s:denite_my_settings()
    function! s:denite_my_settings()"{{{
        nmap <buffer> <ESC> <Plug>(denite_exit)
        imap <buffer> <C-w> <Plug>(denite_delete_backward_path)
        imap <buffer> <C-j> <Plug>(denite_select_next_line)
        imap <buffer> <C-k> <Plug>(denite_select_previous_line)
    endfunction"}}}
  augroup END
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
nnoremap : :<C-U>call NumberIfPresent('n')<CR>:

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

function! NumberIfPresent(m)
    if(&relativenumber == 1 || &number == 1)
        if(a:m ==# 'n')
            set number
        else
            set relativenumber
        endif
    endif
endfunction
" }}}

function! RemoveTrailing()
  %s/\s\+$//e
endfunction

" For latex
let g:tex_flavor='latex' " Get vim to label the file properly

" Edit config quickly
nnoremap <Leader>zz :<C-U>e ~/.config/nvim/init.vim<CR>

function! DiffToggle()
  if &diff
    diffoff
  else
    diffthis
  endif
endfunction

nnoremap <silent> <Leader>df :<C-U>call DiffToggle()<CR>

" ----------- Variable settings for plugins --------------

" Gundo.vim
  nnoremap <Leader>r :GundoToggle<CR>

  " Fugitive shortcuts
  nnoremap <silent> <Leader>gs :<C-U>Gstatus<CR>
  nnoremap <silent> <Leader>gd :<C-U>Gdiff<CR>
  nnoremap <silent> <Leader>gp :<C-U>Gpush<CR>

" Map Denite into some good keybindings
  nnoremap <silent> <Leader>uu :<C-u>Denite
        \  -start-insert file_mru buffer file_rec/async<CR>
  nnoremap <silent> <Leader>um :<C-u>Denite mapping<CR>
  nnoremap <silent> <Leader>ur :<C-u>Denite file_mru<CR>
  nnoremap <silent> <Leader>uj :<C-u>Denite -quick-match buffer<CR>
  nnoremap <silent> <Leader>up :<C-u>Denite process<CR>
  nnoremap <silent> <Leader>ut :<C-u>Denite tag<CR>
  nnoremap <silent> <Leader>ub :<C-u>Denite buffer<CR>
  nnoremap <silent> <Leader>ul :<C-u>Denite line<CR>
  if executable('ag')
    let g:denite_source_rec_async_command='ag --nocolor --nogroup --hidden -g ""'
  endif
  " Make youcompleteme not complete in denite
  let g:ycm_filetype_blacklist = {
      \ 'denite' : 1,
      \}

  " For sneak, use \
  nmap \ <Plug>SneakPrevious
  " For some reason, sneak doesn't map this
  nmap S <Plug>Sneak_S
  nmap s <Plug>Sneak_s
  let g:sneak#streak = 1
  " Ignorecase
  let g:sneak#use_ic_scs = 0

" Merlin from opam
if executable('opam')
  let g:opamshare=substitute(system('opam config var share'),'\n$','','''')
  if isdirectory(g:opamshare."/merlin/vim")
    execute "set rtp+=" . g:opamshare."/merlin/vim"
    let g:merlin_split_method='never'
    let g:merlin_completion_with_doc = 1
  endif
endif

" Deoplete
"if !exists('g:deoplete#omni_patterns')
"  let g:deoplete#omni#input_patterns = {}
"endif
"if !exists('g:deoplete#ignore_sources')
"  let g:deoplete#ignore_sources = {}
"endif
"let g:deoplete#ignore_sources.ocaml = ['buffer', 'around', 'member', 'tag']
" Deoplete options
let g:deoplete#enable_at_startup = 1
let g:deoplete#complete_method = "complete"
"let g:deoplete#omni#input_patterns.ocaml = '[^. *\t]\.\w*|\s\w+|#'
let g:deoplete#max_menu_width = 200
let g:deoplete#max_abbr_width = 200
let g:deoplete#auto_complete_delay = 0
inoremap <expr><C-g>     deoplete#undo_completion()

let g:monster#completion#rcodetools#backend = "async_rct_complete"

" Get rid of mapping of signature so 0 is fast
if mapcheck("0m?", "n")
  nunmap 0m?
endif

" Syntastic
let g:syntastic_ocaml_checkers=['merlin']
let g:syntastic_python_checkers=['flake8']
let g:syntastic_cpp_compiler = 'gcc'
let g:syntastic_cpp_compiler_options = '-std=c++11 -Wall -Wextra -pedantic'
let g:syntastic_cpp_check_header = 1

" Startify bookmarks
let g:startify_bookmarks = ['~/.config/nvim/init.vim', '~/.zshrc']

" CtrlP extensions
"let g:ctrlp_extensions = ['tag', 'buffertag']
"let g:ctrlp_working_path_mode = 'wra'
"let g:ctrlp_switch_buffer = 0 " don't switch to existing buffer
"let g:ctrlp_match_window = 'min:4,max:10,results=100'
"let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" CtrlP calls fzf :Buffers and :Files
nnoremap <C-P> :<C-U>Files<CR>
nnoremap <C-P><C-P> :<C-U>Buffers<CR>
let $FZF_DEFAULT_COMMAND = 'ag -g ""'


" Change ultisnip expand triggers
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" Make vimwiki use Dropbox
let g:vimwiki_list = [{'path': '~/gdrive/wiki/vimwiki/'}]

" NERDTree
let NERDTreeIgnore=[ '\.cmo$[[file]]', '\.o$[[file]]', '\.cmi$[[file]]'
                  \, '\.cmx$[[file]]', '\.cmt$[[file]]', '\.cmti$[[file]]'
                  \, '\.pyc$[[file]]', '\.a$[[file]]'
                  \]

" Make vimfiler the default file explorer
let g:vimfiler_as_default_explorer = 1

" VimShell: Use current directory as vimshell prompt.
let g:vimshell_prompt_expr =
\ 'escape(fnamemodify(getcwd(), ":~").">", "\\[]()?! ")." "'
let g:vimshell_prompt_pattern = '^\%(\f\|\\.\)\+> '

" Grepper
nmap gs <plug>(GrepperOperator)

xmap gs <plug>(GrepperOperator)
nnoremap <leader>gg :<C-U>Grepper -tool git<CR>
nnoremap <leader>ga :<C-U>Grepper -tool ag<CR>
nnoremap <leader>gs :<C-U>Grepper -tool ag -side<CR>
nnoremap <leader>* :<C-U>Grepper -tool ag -cword -noprompt<CR>

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

" Use LSP
if exists('g:nvim_lsp')

:lua << END
  require'nvim_lsp'.pyls.setup()
END

endif

