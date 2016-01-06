" put this line first in ~/.vimrc
set nocompatible | filetype indent plugin on | syn on
set hidden          " Allow buffers to go into the background

call plug#begin('~/.vim/plugged')

Plug 'sjl/gundo.vim'     " Undo graph
Plug 'tmhedberg/matchit' " Match brackets
Plug 'ctrlpvim/ctrlp.vim'        " Fuzzy file matching
Plug 'tpope/vim-abolish' " Easy, simple regex substitutes
Plug 'tpope/vim-surround' " Manipulate parentheses/quotes
Plug 'tpope/vim-unimpaired' " Bracket mappings
Plug 'tpope/vim-repeat'     " Repeat keys
Plug 'tpope/vim-fugitive'       " Git helper
Plug 'tpope/vim-vinegar'    " Enhances using netrw in a window
Plug 'tpope/vim-sleuth'    " Detect file settings
Plug 'tpope/vim-eunuch'    " Unix commands
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic' " Syntax checking
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
Plug 'garbas/vim-snipmate'     " Snippets for snipmate
Plug 'honza/vim-snippets'
Plug 'def-lkb/vimbufsync'      " Heuristics to identify buffer changes
Plug 'justinmk/vim-sneak'      " Quick two-char searching; also replaces easymotion
Plug 'wellle/targets.vim'      " More text objects
Plug 'Peeja/vim-cdo'           " Allows operations over entire quicklist
Plug 'tomtom/tcomment_vim'      " Automatic commenting
Plug 'vimwiki/vimwiki'         " Wiki in vim
Plug 'airblade/vim-gitgutter'  " Show git changes in side
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-peekaboo'   " Show register contents
Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
Plug 'coderifous/textobj-word-column.vim' " Column text object
Plug 'Shougo/unite.vim'        " Menu interface
Plug 'tsukkee/unite-tag'       " Tags for Unite
Plug 'Shougo/neomru.vim'       " MRU for Unite
Plug 'Shougo/vinarise.vim'       " MRU for Unite
Plug 'Shougo/vimfiler.vim'       " MRU for Unite
Plug 'Shougo/vimshell.vim'       " MRU for Unite
Plug 'Shougo/neocomplete.vim'       " MRU for Unite
Plug 'Shougo/vimproc.vim', { 'do': 'make' } " MRU for Unite
Plug 'christoomey/vim-tmux-navigator' " Move around tmux
Plug 'rking/ag.vim'            " Simple AG plugin (maybe best)
Plug 'gabesoft/vim-ags'        " Advanced Silver Searcher plugin
Plug 'dyng/ctrlsf.vim'         " Advanced ag/ack plugin ( choose 1)
Plug 'osyo-manga/vim-monster', { 'for': 'ruby' }  " Ruby completion (requires rcodetools & vimproc)
Plug 'def-lkb/ocp-indent-vim', { 'for': 'ocaml' } " Indentation for ocaml
Plug 'jreybert/vimagit'

call plug#end()

" -------- Qargs code
" from here: http://stackoverflow.com/questions/5686206/search-replace-using-quickfix-list-in-vim/5686810#5686810
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
command! -nargs=1 -complete=command -bang Qargdo exe 'args '.QuickfixFilenames() | argdo<bang> <args>

function! QuickfixFilenames()
" Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

"
" --------- End code

" For keeping info between sessions
set viminfo='500,f1,<500,:500,@500,/500

" For remaining plugins (e.g. k3)
"execute pathogen#infect()

set nocompatible " vim rather than vi settings

set t_Co=256

"colorscheme solarized
let g:solarized_termcolors=256
let g:solarized_visibility="high"
let g:solarized_contrast="high"
set background=light

" allow backspacing over everything
set backspace=indent,eol,start

" 4 space indent
set shiftwidth=2

" 4 stops
set tabstop=2
set softtabstop=2

set expandtab

set autoindent

" Don't save a backup
set nobackup
set nowritebackup

" 50 lines of command line history
set history=100

set gdefault				" regex defaults to g
set hlsearch				" Highlight searched things
set incsearch				" incremental search

" Set ignorecase on
set ignorecase
set smartcase

" Syntax highlighting
syntax on
filetype plugin indent on
set mouse=a

set cursorline
set ruler

" Line numbers
set nu

" Show matching brackets
set showmatch

" Wrap all keys including backspace
set whichwrap=b,s,h,l,<,>,[,]

set clipboard=unnamed

" Prevent breaking up of lines
set textwidth=0 wrapmargin=0

" Visual wrapping enabled
set wrap

" Command completion more useful
set wildmenu " Show many options
set wildmode=longest:full,full  " Complete up to point of ambiguity

" Show window title
set title

set visualbell		" don't beep
set noerrorbells	" don't beep


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
endif


" Grep sometimes doesn't display a filename
set grepprg=grep\ -nH\ $*

" Move all swap files to one directory
set dir=~/temp/swp

" Sessions: don't save some things
set ssop-=options
set ssop-=folds

" Tags should search from current file upwards
" ; indicates searching up, ./ indicates current file
set tags=./tags;

if has("autocmd")
  augroup languages
    autocmd!
    autocmd FileType haskell setlocal tabstop=2 expandtab softtabstop=2
        \ shiftwidth=2 smarttab shiftround nojoinspaces
        \ omnifunc=necoghc#omnifunc
    autocmd FileType ocaml setlocal tabstop=2 expandtab softtabstop=2
        \ shiftwidth=2 smarttab shiftround nojoinspaces
        \ | nnoremap <LocalLeader>l :<C-u>MerlinLocate<CR>
        \ | nnoremap <LocalLeader>o :<C-u>MerlinOccurrences<CR>
    autocmd FileType python setlocal tabstop=4 expandtab softtabstop=4
        \ shiftwidth=4 smarttab shiftround nojoinspaces
    " Make sure quickfix always opens at the bottom
    autocmd FileType qf wincmd J
	autocmd BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl
  augroup END
  " augroup fugitive
    " autocmd!
	" Allow .. instead of :edit %:h when browsing in fugitive (git) trees
	" autocmd User fugitive if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' | nnoremap <buffer> .. :edit %:h<CR> | endif
	" Don't flood open buffers with fugitive files
	" autocmd BufReadPost fugitive://* set bufhidden=delete
  " augroup END
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
  " Settings for unite
  augroup unite_custom
    autocmd FileType unite call s:unite_my_settings()
    function! s:unite_my_settings()"{{{
        nmap <buffer> <ESC> <Plug>(unite_exit)
        imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
        imap <buffer> <C-j> <Plug>(unite_select_next_line)
        imap <buffer> <C-k> <Plug>(unite_select_previous_line)
    endfunction"}}}
  augroup END
endif

" Remaps ------------------------------------
"
" Better leader
nnoremap <SPACE> <Nop>
let mapleader = "\<SPACE>"
let maplocalleader = ","
" Replace , with \ for back searching
" Unnecessary with sneak
"nnoremap \ ,

" For sneak, use \
nmap \ <Plug>SneakPrevious
" For some reason, sneak doesn't map this
nmap S <Plug>Sneak_S
nmap s <Plug>Sneak_s
let g:sneak#streak = 1
" Ignorecase
let g:sneak#use_ic_scs = 0

" For Easymotion
" nmap <SPACE> <leader><leader>s
" vmap <SPACE> <leader><leader>s

" Before we remap, we need to call yankstack setup
" call yankstack#setup()
" nmap <Esc>p <Plug>yankstack_substitute_older_paste
" nmap <Esc>P <Plug>yankstack_substitute_newer_paste

" Map Howdoi
nmap <Esc>h <Plug>Howdoi

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

" Make moving around windows easier
" Turn off stupid bash support
let g:BASH_Ctrl_j = 'off'
"nnoremap <C-h> <C-w>h
"nnoremap <C-j> <C-w>j
"nnoremap <C-k> <C-w>k
"nnoremap <C-l> <C-w>l

" clear highlights
nnoremap <silent> <leader>n :silent :nohlsearch<CR>

nnoremap <silent> <F4> :NERDTree<CR>
nnoremap <silent> <F9> :TagbarToggle<CR>

" Allow C-p and C-n to filter command line
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Fix the & command (repeat subst with flags)
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" Allow easy omnicompletion
" inoremap <C-j> <C-x><C-o>

" QuickFix toggle {{{
nnoremap <silent> <leader>q :call QuickFixToggle()<cr>
let g:quickfix_is_open = 0

" Gundo.vim {{{2
nnoremap <Leader>r :GundoToggle<CR>

" Map Unite into some good keybindings
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <silent> <Leader>uu :<C-u>Unite
    \ -start-insert file_mru buffer file_rec/async<CR>
" nnoremap <silent> <C-p> :<C-u>Unite
"    \ -start-insert buffer file_rec/async file_mru<CR>
nnoremap <silent> <Leader>um :<C-u>Unite mapping<CR>
nnoremap <silent> <Leader>ur :<C-u>Unite file_mru<CR>
nnoremap <silent> <Leader>uj :<C-u>Unite -quick-match buffer<CR>
nnoremap <silent> <Leader>up :<C-u>Unite process<CR>
nnoremap <silent> <Leader>ut :<C-u>Unite tag<CR>
nnoremap <silent> <Leader>ub :<C-u>Unite buffer<CR>
nnoremap <silent> <Leader>ul :<C-u>Unite line<CR>
if executable('ag')
  let g:unite_source_rec_async_command='ag --nocolor --nogroup --hidden -g ""'
endif

" Map easyalign to visual mode's enter
vnoremap <silent> <CR> :EasyAlign<CR>
vnoremap <silent> <Leader><CR> :LiveEasyAlign<CR>

nnoremap <silent> <Leader>gs :<C-U>Gstatus<CR>
nnoremap <silent> <Leader>gd :<C-U>Gdiff<CR>
nnoremap <silent> <Leader>gp :<C-U>Gpush<CR>

" Make youcompleteme not complete in unite
let g:ycm_filetype_blacklist = {
    \ 'unite' : 1,
    \}

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

" Variable settings for plugins --------------

" Space.vim {{{2
" Makes space awesome in normal mode
let g:space_disable_select_mode=1
let g:space_no_search = 1

" For Alternate extension. Allow switching between interface and source ocaml
" files
let g:alternateExtensions_ML="mli"

" For latex
let g:tex_flavor='latex' " Get vim to label the file properly

" Configure browser for haskell_doc.vim -- warning: only for mac!!!
let g:haddock_browser = "open"
let g:haddock_browser_callformat = "%s %s"

" Merlin
let g:opamshare=substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare."/merlin/vim"
let g:merlin_split_method='never'

highlight EnclosingExpr ctermbg=Red

" Make merlin use neocomplcache (omni-complete)
" if !exists('g:neocomplcache_force_omni_patterns')
"   let g:neocomplcache_force_omni_patterns = {}
" endif
" let g:neocomplcache_force_omni_patterns.ocaml = '[^. *\t]\.\w*\|\h\w*|#'

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ocaml = '[^. *\t]\.\w*\|\h\w*|#'

let g:monster#completion#rcodetools#backend = "async_rct_complete"
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Get rid of mapping of signature so 0 is fast
if mapcheck("0m?", "n")
  nunmap 0m?
endif

let g:syntastic_ocaml_checkers=['merlin']
let g:syntastic_python_checkers=['flake8']
" let g:syntastic_cpp_compiler = 'clang++'
" let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
" let g:syntastic_cpp_check_header = 1

" Easymotion remap to s. This conflicts with surround for delete, yank etc, but that's ok.
"let g:EasyMotion_leader_key = 's'

" Make supertab use context to determine what to fill in
let g:SuperTabDefaultCompletionType = "context"

" Startify bookmarks
let g:startify_bookmarks = ['~/.vimrc', '~/.bashrc']

" CtrlP extensions
let g:ctrlp_extensions = ['tag', 'buffertag']
let g:ctrlp_working_path_mode = 'wra'
let g:ctrlp_switch_buffer = 0 " don't switch to existing buffer

" Change ultisnip expand triggers
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" Make vimwiki use Dropbox
let g:vimwiki_list = [{'path': '~/Dropbox/wiki/vimwiki/'}]

" NerdTreeIgnore
let NERDTreeIgnore=[ '\.cmo$[[file]]', '\.o$[[file]]', '\.cmi$[[file]]'
                  \, '\.cmx$[[file]]', '\.cmt$[[file]]', '\.cmti$[[file]]'
                  \, '\.pyc$[[file]]'
                  \]
"" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
nmap <Leader>a <Plug>(EasyAlign)

" Make vimfiler the default file explorer
let g:vimfiler_as_default_explorer = 1

" Use current directory as vimshell prompt.
let g:vimshell_prompt_expr =
\ 'escape(fnamemodify(getcwd(), ":~").">", "\\[]()?! ")." "'
let g:vimshell_prompt_pattern = '^\%(\f\|\\.\)\+> '
