function! ToggleStatus()
	if !exists('g:show_status')
		let g:show_status = 1

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

	elseif g:show_status == 1
		unlet g:show_status

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
call ToggleStatus()

nnoremap <silent> <leader>ts :call ToggleStatus()<CR>
