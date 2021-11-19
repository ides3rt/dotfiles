" `colemak` style movement
noremap <silent> n h
noremap <silent> e gj
noremap <silent> i gk
noremap <silent> o l
noremap j <Nop>

"Keys get overwrite by `colemak`
noremap <silent> h i
noremap <silent> l n
noremap <silent> k o

"Same as above, but capital
noremap <silent> H I
noremap <silent> L N
noremap <silent> K O

"Move up and down
noremap <silent> E 10gj
noremap <silent> I 10gk

"Move the current line up or down
noremap <silent> <C-e> :move +1<CR>
noremap <silent> <C-i> :move -2<CR>
