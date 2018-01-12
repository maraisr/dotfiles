set nocompatible
set encoding=utf-8

set shell=/bin/bash
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" Utils
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/syntastic'

" Syntax
Plugin 'tpope/vim-markdown'
Plugin 'rust-lang/rust.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'leafgarland/typescript-vim'
Plugin 'digitaltoad/vim-pug'

" Rust
Plugin 'racer-rust/vim-racer'

" Web
Plugin 'skammer/vim-css-color'

call vundle#end()

filetype plugin indent on
filetype plugin on
syntax on

set hidden
set showcmd
set number
set smartindent
set showmatch
set hlsearch
set incsearch
set noswapfile
set nocursorline
set autoread
set ruler
set backspace=indent,eol,start

" Plugin configs

let g:airline_theme='luna'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:gitgutter_updatetime = 750
let g:racer_cmd = "~/.cargo/bin/racer"

" Functions

function! StatusLineFileSize()
  let size = getfsize(expand('%%:p'))
  if (size < 1024)
    return size . 'b '
  else
    let size = size / 1024
    return size . 'k '
  endif
endfunction
