set shell=/usr/bin/env\ bash

filetype plugin indent on
filetype plugin on

syntax on

let mapleader = ","

set nocompatible
set encoding=utf-8
set hidden
set showcmd
set cursorline
set number
set smartindent
set showmode
set showmatch
set noswapfile
set formatoptions=l
set autoread
set ruler
set backspace=indent,eol,start
set title
set wrap						" Soft wrap lines
set lbr							" Better line breaks when wrapping

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

call plug#end()
