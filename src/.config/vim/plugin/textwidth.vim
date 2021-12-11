"Disable `textwidth` by default
func! Textwidth()
	if !exists('g:Textwidth')
		let g:Textwidth = 1
		set textwidth=0

	elseif g:Textwidth == 1
		unlet g:Textwidth
		set textwidth=80

	endif
endfunc
call Textwidth()

nnoremap <silent> <leader>tw :call Textwidth()<CR>
