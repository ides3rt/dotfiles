"Disable `textwidth` by default
if !exists('g:Textwidth')
	let g:Textwidth = 0
endif

func! Textwidth()
	if g:Textwidth == 0
		let g:Textwidth = 1
		set textwidth=0

	elseif g:Textwidth == 1
		let g:Textwidth = 0
		set textwidth=80
	endif
endfunc
call Textwidth()

noremap <silent> <leader>tw :call Textwidth()<CR>
