execute pathogen#infect()
syntax on
filetype plugin indent on

:set switchbuf+=newtab

" tab navigation like firefox
set showtabline=2               " File tabs allways visible

:nmap <C-S-h> :tabprevious<cr>
:nmap <C-l> :tabnext<cr>
:map <C-S-h> :tabprevious<cr>
:map <C-l> :tabnext<cr>
:imap <C-S-h> <ESC>:tabprevious<cr>i
:imap <C-l> <ESC>:tabnext<cr>i
:nmap <C-t> :tabnew<cr>
:map <C-t> :tabnew<cr>
:imap <C-t> <ESC>:tabnew<cr>
:map <C-w> :tabclose<cr>

set relativenumber
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set encoding=utf8
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" For any plugins that use this, make their keymappings use comma
let mapleader = ","
let maplocalleader = ","

" FZF (replaces Ctrl-P, FuzzyFinder and Command-T)
set rtp+=~/.fzf
nmap ; :Buffers<CR>
nmap <Leader>t :Tags<CR>
nmap <Leader>f :Files<CR>
nmap <Leader>a :Ag<CR>

" Tell ack.vim to use ag (the Silver Searcher) instead
let g:ackprg = 'ag --vimgrep'
