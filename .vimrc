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
        \  'abolish', 'Gundo', 'ReplaceWithRegister', 'LaTeX-Suite_aka_Vim-LaTeX'
        \, 'LustyJuggler', 'snipmate-snippets', 'unimpaired', 'vimwiki' 
        \, 'bufexplorer.zip', 'matchit.zip', 'Solarized', 'yankstack', 'ctrlp'
        \, 'The_NERD_Commenter', 'surround', 'EasyMotion', 'The_NERD_tree'
        \, 'Tabular', 'fugitive', 'repeat', 'taglist', 'Syntastic'
        \, 'ack', 'vimux', 'vim-signature', 'Powerline', 'mayansmoke'
        \, 'tslime', 'glsl', 'textobj-lastpat', 'textobj-user', 'textobj-syntax'
        \, 'space', "github:nelstrom/vim-visual-star-search"
        \], {'auto_install' : 0})
    "disabled: 
    ", 'neocomplcache', 'Headlights', 'AutoTag' 
    "
    " Textobj-lastpat: make a text object / for the last pattern searched for
    " space: make space a generic repeat for all movement commands
    " repeat: Make . repeat plugin commands

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
" --------- End code

" For remaining plugins (e.g. merlin)
execute pathogen#infect()

set nocompatible " vim rather than vi settings

" allow backspacing over everything
set backspace=indent,eol,start

" 4 space indent
set shiftwidth=4

" 4 stops
set tabstop=4

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

set background=light
"colorscheme solarized
"let g:solarized_termcolors=256

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
set wildignore+=*.cmi,*.cmo,*.annot,*.orig,*.swp,*.o
let g:ctrlp_custom_ignore = {
	\ 'dir': '\v\/bin$'
  \ }

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

if has("autocmd")
	autocmd FileType haskell setlocal tabstop=2 expandtab softtabstop=2 shiftwidth=2 smarttab shiftround nojoinspaces
	autocmd FileType ocaml setlocal tabstop=2 expandtab softtabstop=2 shiftwidth=2 smarttab shiftround nojoinspaces
	" Allow .. instead of :edit %:h when browsing in fugitive (git) trees
	autocmd User fugitive if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' | nnoremap <buffer> .. :edit %:h<CR> | endif
	" Don't flood open buffers with fugitive files
	autocmd BufReadPost fugitive://* set bufhidden=delete
	" Remove search highlighting for insert mode
	autocmd InsertEnter * :setlocal nohlsearch
	autocmd InsertLeave * :setlocal hlsearch
	autocmd BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl
endif

" Remaps ------------------------------------
"
" Better leader
let mapleader = ","
" Replace , with \ for back searching
noremap \ ,

" Before we remap, we need to call yankstack setup
call yankstack#setup()
nmap <Esc>p <Plug>yankstack_substitute_older_paste
nmap <Esc>P <Plug>yankstack_substitute_newer_paste

" Map jk to esc
inoremap jk <Esc>
" Map x so it doesn't record (we don't need single characters in registers)
nnoremap x "_x
nnoremap X "_X
nnoremap Y y$
" Prevent ex mode from Q
nnoremap Q <nop> 

" Make going down/up long lines easier
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" Make moving around windows easier
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" clear highlights
" nnoremap <C-l> :nohlsearch<CR><C-l>  " Conflicts with movement
nmap <silent> <leader>n :silent :nohlsearch<CR>

nnoremap <Leader>j :LustyJuggler<CR>
nnoremap <silent> <F4> :NERDTree<CR>

" Allow C-p and C-n to filter command line
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>


" Variable settings for plugins --------------

" Gundo.vim {{{2
map <Leader>u :GundoToggle<CR>

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

" Make merlin use neocomplcache (omni-complete)
if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.ocaml = '[^. *\t]\.\w*\|\h\w*|#'

" For ocaml files with extra syntax. This really slows stuff down though
" let g:syntastic_ocaml_use_ocamlbuild = 1
let g:syntastic_ocaml_checkers=['merlin']

" Easymotion remap to s
nmap s <Leader><Leader>
vmap s <Leader><Leader>
"let g:EasyMotion_mapping_f = 'sf'
"let g:EasyMotion_mapping_F = 'sF'
"let g:EasyMotion_mapping_t = 'st'
"let g:EasyMotion_mapping_T = 'sT'
"let g:EasyMotion_mapping_w = 'sw'
"let g:EasyMotion_mapping_W = 'sW'
"let g:EasyMotion_mapping_b = 'sb'
"let g:EasyMotion_mapping_B = 'sB'
"let g:EasyMotion_mapping_e = 'se'
"let g:EasyMotion_mapping_E = 'sE'
"let g:EasyMotion_mapping_ge = 'sge'
"let g:EasyMotion_mapping_gE = 'sgE'
"let g:EasyMotion_mapping_j = 'sj'
"let g:EasyMotion_mapping_k = 'sk'
"let g:EasyMotion_mapping_n = 'sn'
"let g:EasyMotion_mapping_N = 'sN'

