set shell=/usr/bin/env\ bash

filetype plugin indent on
filetype plugin on

syntax on

set nocompatible
set encoding=utf-8
set hidden
set showcmd
set cursorline
set number
set smartindent
set showmode
set showmatch
set hlsearch
set incsearch
set noswapfile
set formatoptions=l 
set autoread
set ruler
set backspace=indent,eol,start
set title
set nobackup
set list
set listchars=tab:\│\ ,eol:↲
set listchars+=nbsp:␣
set listchars+=trail:•
set listchars+=extends:⟩
set listchars+=precedes:⟨

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
        function! StatusLineFileSize()
            let size = getfsize(expand('%%:p'))
            if (size < 1024)
                return size . 'b '
            else
                let size = size / 1024
                return size . 'k '
            endif
        endfunction
    
    Plug 'vim-airline/vim-airline-themes'
        let g:airline_theme='luna'
    " }}}

call plug#end()
