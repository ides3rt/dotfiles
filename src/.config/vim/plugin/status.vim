"Don't show status by default
func! Status()
	if !exists('g:Status')
		let g:Status = 1

		if has('syntax')
			set nocursorline
			set colorcolumn=0
		endif

		set nonumber

		if has('cmdline_info')
			set noruler
		endif

		if has('statusline')
			set laststatus=1
		endif

	elseif g:Status == 1
		unlet g:Status

		if has('syntax')
			set cursorline
			set colorcolumn=80
		endif

		set number

		if has('cmdline_info')
			set ruler
		endif

		if has('statusline')
			set laststatus=2
		endif

	endif
endfunction
call Status()

"Toggle status
nnoremap <silent> <leader>ts :call Status()<CR>
