set shell=/usr/bin/env\ bash

filetype plugin indent on
filetype plugin on

syntax on

let mapleader = ","

set nocompatible
set encoding=utf-8
set t_Co=256						" 256 colour mode
set hidden
set showcmd
set cursorline						" Add a line under the current line
set number
set smartindent
set showmode
set showmatch
set noswapfile
set formatoptions=l
set autoread						" Refresh file from extnernal changes
set ruler						" Line number and columne number
set backspace=indent,eol,start				" Allow over backspaceing over everthing in INSERT mode
set title						" Updates the window title
set history=500						" Keep 100 lines of command history

set wrap						" Soft wrap lines
set lbr							" Better line breaks when wrapping
set textwidth=120					" Wrap text at 120
set colorcolumn=120					" Highlight at 120

set list						" show whitespace chars
set listchars=tab:\│\ ,eol:↲				" Bars for tabs, show eol chars
set listchars+=nbsp:␣					" Show nonbreaking spaces
set listchars+=trail:•					" Highlight trailing whitespace
set listchars+=extends:⟩				" Char to show when no wrap but text extends right
set listchars+=precedes:⟨				" Char to show when no wrap but text extends left

set incsearch						" Search more like you would in browsers
set ignorecase						" Ignores case when searching
set smartcase						" Be smart about searching
set hlsearch						" Highlight searches
set magic						" Regex in searches

set lazyredraw						" Don't redraw until i've finished with my commands

" Stops annowing terminal bell
set noerrorbells
set novisualbell

set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif

autocmd BufRead,BufNewFile * setlocal signcolumn=yes

call plug#begin('~/.vim/plugged')

    " Refactor {{{
    Plug 'peterrincker/vim-argumentative'
    " }}}

    " VCS {{{
    Plug 'airblade/vim-gitgutter'
        let g:gitgutter_updatetime = 750
    " }}}

    " Look and Feel {{{
    Plug 'jeffkreeftmeijer/vim-numbertoggle'

    Plug 'vim-airline/vim-airline'

    Plug 'vim-airline/vim-airline-themes'
        let g:airline_theme='luna'
    " }}}

    " Langauges {{{
    Plug 'leafgarland/typescript-vim'
    Plug 'jelera/vim-javascript-syntax'
    Plug 'pangloss/vim-javascript'
    Plug 'gorodinskiy/vim-coloresque'
    " }}}

call plug#end()
