:filetype plugin on
set runtimepath^=~/.vim/bundle/ctrlp.vim
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
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

