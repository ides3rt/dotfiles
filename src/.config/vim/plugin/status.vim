"Don't show status by default
if !exists('g:Status')
	let g:Status = 0
endif

func! ToggleStatus()
	if g:Status == 0
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
		let g:Status = 0

		if has('syntax')
			set cursorline
			set colorcolumn=-1
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

"Toggle status
noremap <silent> <leader>ts :call ToggleStatus()<CR>
