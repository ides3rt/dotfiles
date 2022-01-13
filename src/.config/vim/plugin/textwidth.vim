"To toggle textwidth
func! Textwidth()
	if !exists('g:Textwidth')
		let g:Textwidth = 1
		set textwidth=0

	elseif g:Textwidth == 1
		unlet g:Textwidth
		set textwidth=80

	endif
endfunc

nnoremap <silent> <leader>tw :call Textwidth()<CR>
