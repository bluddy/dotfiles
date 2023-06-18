
fun! SetupPlug()
  let root_dir = expand('$HOME', 1) . '/.local/share/nvim/site'
  if !filereadable(root_dir . '/autoload/plug.vim')
    execute '!curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  endif
endfun

call SetupPlug()

call plug#begin('~/.local/share/nvim/plugged')

Plug 'tmhedberg/matchit' " Match brackets
Plug 'andymass/vim-matchup' " Modern matchit
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
Plug 'godlygeek/tabular' " Aligning tables
Plug 'kshenoy/vim-signature'   " Display marks
Plug 'kana/vim-textobj-lastpat'
Plug 'kana/vim-textobj-user'   " User defined text objects
Plug 'kana/vim-textobj-syntax' " Syntax highlighted items
Plug 'kana/vim-textobj-line'
Plug 'bronson/vim-visual-star-search' " Search from a visual pattern
Plug 'mhinz/vim-startify'      " Nice opening screen
Plug 'wellle/targets.vim'      " More text objects
Plug 'Peeja/vim-cdo'           " Allows operations over entire quicklist
Plug 'tomtom/tcomment_vim'      " Automatic commenting
Plug 'vimwiki/vimwiki'         " Wiki in vim

Plug 'junegunn/vim-easy-align'
Plug 'coderifous/textobj-word-column.vim' " Column text object
Plug 'christoomey/vim-tmux-navigator' " Move around tmux
"Plug 'mhinz/vim-grepper'       " Asynchronous search with ag etc
Plug 'jreybert/vimagit'        " Cool interface for git
Plug 'rhysd/git-messenger.vim' " Explore commit messages per line
Plug 'lervag/vimtex'           " Advanced latex plugin
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'tpope/vim-obsession'     " Auto vim session saving
Plug 'jpalardy/vim-slime'      " Copy to tmux

Plug 'roxma/vim-tmux-clipboard' " Integrate vim and tmux clipboards
" Plug 'rgrinberg/vim-ocaml'    " Ocaml runtime syntax higlighting
" Plug 'w0rp/ale' " Asynchronous lint engine
" Plug 'nacitar/a.vim' " Switch between related files
" Plug 'samoshkin/vim-mergetool'
" Plug 'regedarek/ZoomWin' " C-w o to zoom in/out
" Plug 'sbdchd/neoformat' " Formatting tool :Neoformat, can do ocp-indent
" Plug 'nvim-treesitter/nvim-treesitter' " Treesitter (TInstall)
" Plug 'ncm2/float-preview.nvim' " Floating window support instead of preview window
" Plug 'puremourning/vimspector' " Debug Protocol Integration
"
Plug 'nvim-lualine/lualine.nvim' " Fast status line

Plug 'kyazdani42/nvim-web-devicons' " Icons for statusline

Plug 'nvim-lua/plenary.nvim' " General lua library

Plug 'neovim/nvim-lspconfig' " LSP default configurations

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp' " Completion

Plug 'frankier/neovim-colors-solarized-truecolor-only'
"Plug 'shaunsingh/solarized.nvim'

" For vsnip users.
"Plug 'hrsh7th/cmp-vsnip'
"Plug 'hrsh7th/vim-vsnip'
Plug 'L3MON4D3/LuaSnip'

" Plug 'tami5/lspsaga.nvim' " Extra LSP functionality, disable for now
Plug 'nvim-telescope/telescope.nvim' " Like C-P
Plug 'Phaazon/hop.nvim' " Like sneak

Plug 'tversteeg/registers.nvim' " Display registers

Plug 'kyazdani42/nvim-tree.lua' " Fast replacement for nerdtree
Plug 'preservim/nerdtree'

" Plug 'blackCauldron7/surround.nvim' " Not ready for prime time

call plug#end()
