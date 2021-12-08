func! Syntax()
	if !exists('g:Syntax')
		let g:Syntax = 1
		let g:Colorscheme = g:colors_name
		syntax off
		highlight clear
	elseif g:Syntax == 1
		unlet g:Syntax
		syntax on
		exe "colorscheme ".g:Colorscheme
	endif
endfunc

nnoremap <silent> <leader>sn :call Syntax()<CR>
