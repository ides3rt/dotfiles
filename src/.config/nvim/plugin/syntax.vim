function! Toggle_Syntax()
	if !exists('g:use_syntax')
		let g:use_syntax = 1
		let g:old_colors = g:colors_name
		syntax off | highlight clear
		hi Normal ctermbg=none ctermfg=none cterm=none

	elseif g:use_syntax == 1
		unlet g:use_syntax | syntax on
		exec "colorscheme " . g:old_colors
		unlet g:old_colors

	endif
endfunction

nnoremap <silent> <leader>ns :call Toggle_Syntax()<CR>
