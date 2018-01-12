set nocompatible
set encoding=utf-8

set shell=/bin/bash
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" Utils
Plugin 'airblade/vim-gitgutter'

" Rust
Plugin 'rust-lang/rust.vim'
Plugin 'racer-rust/vim-racer'

" Web
Plugin 'pangloss/vim-javascript'
Plugin 'digitaltoad/vim-pug'

call vundle#end()

filetype plugin indent on
filetype plugin on
syntax on

set hidden
set showcmd
set number
set smartindent
set showmatch
set incsearch
set noswapfile
set nocursorline
set autoread
set ruler

" Rust config
let g:racer_cmd = "~/.cargo/bin/racer"
