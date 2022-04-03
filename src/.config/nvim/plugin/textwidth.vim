function! Toggle_Textwidth()
	if !exists('g:use_textwidth')
		let g:use_textwidth = 1
		set textwidth=0

	elseif g:use_textwidth == 1
		unlet g:use_textwidth
		set textwidth=80

	endif
endfunction

nnoremap <silent> <leader>tw :call Toggle_Textwidth()<CR>
