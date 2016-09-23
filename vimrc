execute pathogen#infect()
syntax on
filetype plugin indent on

:set switchbuf+=newtab

if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  
  " bind K to grep word under cursor
  nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
endif

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
set expandtab
set encoding=utf8
set exrc
