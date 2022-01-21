func! Syntax()
	if !exists('g:Syntax')
		let g:Syntax = 1
		let g:Colorscheme = g:colors_name
		syntax off | highlight clear
		hi Normal ctermbg=none ctermfg=none cterm=none

	elseif g:Syntax == 1
		unlet g:Syntax | syntax on
		exec "colorscheme " . g:Colorscheme
		unlet g:Colorscheme

	endif
endfunc

nnoremap <silent> <leader>ns :call Syntax()<CR>
