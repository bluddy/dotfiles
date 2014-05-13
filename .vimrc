" put this line first in ~/.vimrc
set nocompatible | filetype indent plugin on | syn on

fun! EnsureVamIsOnDisk(plugin_root_dir)
    " windows users may want to use http://mawercer.de/~marc/vam/index.php
    " to fetch VAM, VAM-known-repositories and the listed plugins
    " without having to install curl, 7-zip and git tools first
    " -> BUG [4] (git-less installation)
    let vam_autoload_dir = a:plugin_root_dir.'/vim-addon-manager/autoload'
    if isdirectory(vam_autoload_dir)
    return 1
    else
    if 1 == confirm("Clone VAM into ".a:plugin_root_dir."?","&Y\n&N")
        " I'm sorry having to add this reminder. Eventually it'll pay off.
        call confirm("Remind yourself that most plugins ship with ".
                    \"documentation (README*, doc/*.txt). It is your ".
                    \"first source of knowledge. If you can't find ".
                    \"the info you're looking for in reasonable ".
                    \"time ask maintainers to improve documentation")
        call mkdir(a:plugin_root_dir, 'p')
        execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '.
                    \ shellescape(a:plugin_root_dir, 1).'/vim-addon-manager'
        " VAM runs helptags automatically when you install or update
        " plugins
        exec 'helptags '.fnameescape(a:plugin_root_dir.'/vim-addon-manager/doc')
    endif
    return isdirectory(vam_autoload_dir)
    endif
endfun

fun! SetupVAM()
    " Set advanced options like this:
    " let g:vim_addon_manager = {}
    " let g:vim_addon_manager.key = value
    " Pipe all output into a buffer which gets written to disk
    " let g:vim_addon_manager.log_to_buf =1

    " Example: drop git sources unless git is in PATH. Same plugins can
    " be installed from www.vim.org. Lookup MergeSources to get more control
    " let g:vim_addon_manager.drop_git_sources = !executable('git')
    " let g:vim_addon_manager.debug_activation = 1

    " VAM install location:
    let c = get(g:, 'vim_addon_manager', {})
    let g:vim_addon_manager = c
    let c.plugin_root_dir = expand('$HOME/.vim/vim-addons')
    if !EnsureVamIsOnDisk(c.plugin_root_dir)
    echohl ErrorMsg | echomsg "No VAM found!" | echohl NONE
    return
    endif
    let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'

    " Tell VAM which plugins to fetch & load:
    call vam#ActivateAddons([
        \  'abolish'
        \, 'Gundo'
        \, 'LustyJuggler' 
        \, 'UltiSnips'
        \, 'unimpaired'
        \, 'bufexplorer.zip'
        \, 'matchit.zip' 
        \, 'Solarized'
        \, 'ctrlp'
        \, 'The_NERD_Commenter'
        \, 'surround'
        \, 'The_NERD_tree'
        \, 'Tabular'
        \, 'repeat'
        \, 'taglist'
        \, 'Syntastic'
        \, 'ack'
        \, 'ag'
        \, 'vimux'
        \, 'vim-signature'
        \, 'vim-airline'
        \, 'mayansmoke'
        \, 'tslime'
        \, 'glsl' 
        \, 'textobj-lastpat'
        \, 'textobj-user'
        \, 'textobj-syntax'
        \, 'textobj-line'
        \, 'github:nelstrom/vim-visual-star-search'
        \, 'vim-startify'
        \, 'github:dhruvasagar/vim-table-mode'
        \, 'Rainbow_Parentheses_Improved'
        \, 'github:regedarek/ZoomWin'
        \, 'NrrwRgn'
        \, 'vim-snippets'
        \, 'vimbufsync'
        \, 'fugitive'
        \, 'vim-sneak'
        \, 'vimproc'
        \, 'vimshell'
        \, 'neocomplete'
        \, 'unite'
        \, 'github:wellle/targets.vim'
        \, 'vim-howdoi'
        \, 'github:bluddy/vim-yankstack'
        \, 'github:christoomey/vim-tmux-navigator'
        \, 'github:tpope/vim-vinegar'
        \, 'github:Peeja/vim-cdo'
        \], {'auto_install' : 0})
    "disabled: 
        "\, 'EasyMotion'
        "\, 'gitv'
        "\, 'YouCompleteMe'
    "\, 'Tagbar'
    "\, 'vim-easy-align'
    ", 'SuperTab%1643'
    ", 'neocomplcache', 'Headlights', 'AutoTag', 'space', 'powerline'
    " Textobj-lastpat: make a text object / for the last pattern searched for
    " space: make space a generic repeat for all movement commands
    " repeat: Make . repeat plugin commands
    " RelOps: just use relative nums always
    " 'github:bolted/vim-tmux-navigator'
    " 'github:bluddy/vim-insert-operator'
    "'ReplaceWithRegister' 
    " , 'vimwiki' 
    "     'unite'
    "'LaTeX-Suite_aka_Vim-LaTeX'

    " Addons are put into plugin_root_dir/plugin-name directory
    " unless those directories exist. Then they are activated.
    " Activating means adding addon dirs to rtp and do some additional
    " magic

    " How to find addon names?
    " - look up source from pool
    " - (<c-x><c-p> complete plugin names):
    " You can use name rewritings to point to sources:
    " ..ActivateAddons(["github:foo", .. => github://foo/vim-addon-foo
    " ..ActivateAddons(["github:user/repo", .. => github://user/repo
    " Also see section "2.2. names of addons and addon sources" in VAM's documentation
endfun
call SetupVAM()

" Stuff not for macvim (version problem)
"if !has("gui_macvim")
    "call vam#ActivateAddons([
        "\ 'YouCompleteMe'
        "\], {'auto_install' : 0})
"endif

" --------- End VAM ----------------
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
set wildmode=longest:list  " Complete up to point of ambiguity

" Show window title
set title

set visualbell		" don't beep
set noerrorbells	" don't beep

set hidden          " Allow buffers to go into the background

set virtualedit=block  " Make block editing better

" Make paste mode easy
set pastetoggle=<F2>

" Make status line appear on one window
set ls=2

" Make Ctrl-P and others not search certain files
set wildignore+=*.cmi,*.cmo,*.annot,*.orig,*.swp,*.o,*/bin/*,_build/*

" Make vim batch screen updates
set lazyredraw

highlight DiffText ctermbg=LightBlue
highlight EnclosingExpression ctermbg=Red
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

if has("autocmd")
  augroup languages
    autocmd!
	autocmd FileType haskell setlocal tabstop=2 expandtab softtabstop=2 shiftwidth=2 smarttab shiftround nojoinspaces
    autocmd FileType ocaml setlocal tabstop=2 expandtab softtabstop=2 shiftwidth=2 smarttab shiftround nojoinspaces makeprg=ocamlbuild\ '%:~:.:r.byte'
    "let s:path = substitute(system('opam config var share'),'\n$','','''') . "/vim/syntax/ocp-indent.vim"
    "autocmd FileType ocaml source s:path
    "autocmd FileType ocaml ~/source/damsl/* setlocal makeprg=~/src/damsl/build.sh
    " Make sure quickfix always opens at the bottom
    autocmd FileType qf wincmd J
	autocmd BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl
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
let mapleader = ","
" Replace , with \ for back searching
" Unnecessary with sneak
"nnoremap \ , 

" For sneak, use \
nmap \ <Plug>SneakPrevious
let g:sneak#streak = 1
" Ignorecase
let g:sneak#use_ic_scs = 0

" For Easymotion
nmap <SPACE> <leader><leader>s
vmap <SPACE> <leader><leader>s

" Before we remap, we need to call yankstack setup
call yankstack#setup()
nmap <Esc>p <Plug>yankstack_substitute_older_paste
nmap <Esc>P <Plug>yankstack_substitute_newer_paste

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

" Swap " and ' for easy access to register
nnoremap " '
nnoremap ' "

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

nnoremap <Leader>j :LustyJuggler<CR>
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
nnoremap <silent> <Leader>uu :<C-u>Unite 
    \ -start-insert buffer file_rec file_mru<CR>
nnoremap <silent> <Leader>um :<C-u>Unite mapping<CR>
nnoremap <silent> <Leader>uj :<C-u>Unite -quick-match buffer<CR>
nnoremap <silent> <Leader>up :<C-u>Unite process<CR>

" Map easyalign to visual mode's enter
vnoremap <silent> <CR> :EasyAlign<CR>
vnoremap <silent> <Leader><CR> :LiveEasyAlign<CR>

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

" Variable settings for plugins --------------

" Space.vim {{{2
" Makes space awesome in normal mode
let g:space_disable_select_mode=1
let g:space_no_search = 1

" For Alternate extension. Allow switching between interface and source ocaml
" files
let g:alternateExtensions_ML="mli"
let g:LustyJugglerSuppressRubyWarning=1  " Suppress Lusty Juggler's ruby messages
let g:LustyJugglerDefaultMappings=0 " Don't use LJ's defaults

" For latex
let g:tex_flavor='latex' " Get vim to label the file properly

" Configure browser for haskell_doc.vim -- warning: only for mac!!!
let g:haddock_browser = "open"
let g:haddock_browser_callformat = "%s %s"

" Merlin
let s:ocamlmerlin=substitute(system('opam config var share'),'\n$','','''') .  "/ocamlmerlin"
execute "set rtp+=".s:ocamlmerlin."/vim"
execute "set rtp+=".s:ocamlmerlin."/vimbufsync"

" Make merlin use neocomplcache (omni-complete)
if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.ocaml = '[^. *\t]\.\w*\|\h\w*|#'

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ocaml = '[^. *\t]\.\w*\|\h\w*|#'

" Use neocomplete.
let g:neocomplete#enable_at_startup = 1

let g:syntastic_ocaml_checkers=['merlin']

" Easymotion remap to s. This conflicts with surround for delete, yank etc, but that's ok.
"let g:EasyMotion_leader_key = 's'

" Make supertab use context to determine what to fill in
let g:SuperTabDefaultCompletionType = "context"

" Startify bookmarks
let g:startify_bookmarks = ['~/.vimrc', '~/.bashrc']

" CtrlP extensions
let g:ctrlp_extensions = ['tag', 'buffertag']
let g:ctrlp_working_path_mode = 'wra'

" Change ultisnip expand triggers 
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

