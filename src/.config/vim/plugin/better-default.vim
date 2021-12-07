"For wrap users
noremap j gj
noremap k gk

"Use CAP instead of 10
noremap J 10j
noremap K 10k

"Tabs
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

"Move current line UP or DOWN
inoremap <silent> <C-j> <ESC>:move +1<CR>i
inoremap <silent> <C-k> <ESC>:move -2<CR>i

"Simple EMACS keys on norm and vis mode
noremap <C-e> <end>
noremap <C-a> <home>

"Simple EMACS keys on insert mode
inoremap <C-f> <right>
inoremap <C-b> <left>
inoremap <C-e> <end>
inoremap <C-a> <home>

"Simple EMACS keys on command mode
cnoremap <C-f> <right>
cnoremap <C-b> <left>
cnoremap <C-e> <end>
cnoremap <C-a> <home>
