"Don't show status by default
if !exists('g:hidden_all')
	let g:hidden_all = 1
endif

func! ToggleHiddenAll()
	if g:hidden_all == 0
		let g:hidden_all = 1
		set nonumber

		if has('cmdline_info')
			set noruler
		endif

		if has('statusline')
			set laststatus=0
		endif

		if has('syntax')
			set nocursorline
		endif

	elseif g:hidden_all == 1
		let g:hidden_all = 0
		set number

		if has('cmdline_info')
			set ruler
		endif

		if has('syntax')
			set cursorline
		endif

		if has('statusline')
			set laststatus=2
		endif

    endif
endfunction
call ToggleHiddenAll()

"Toggle status
noremap <silent> <leader>hh :call ToggleHiddenAll()<CR>
