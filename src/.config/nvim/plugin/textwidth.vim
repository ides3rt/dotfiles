func! ToggleTextwidth()
	if !exists('g:use_textwidth')
		let g:use_textwidth = 1
        let g:my_textwidth = &textwidth
		set textwidth=0

	elseif g:use_textwidth == 1
		unlet g:use_textwidth
		exec "set textwidth=" . g:my_textwidth
        unlet g:my_textwidth

	endif
endfunc

nnoremap <silent> <leader>tw :call ToggleTextwidth()<CR>
