"Syntax and Filetype
syntax on
filetype on
filetype plugin on
filetype indent on

"Use <space> as my <leader>
noremap <space> <Nop>
let mapleader=" "

"My colors scheme
source $HOME/.config/vim/colors/ides3rt.vim

"Indent
set autoindent

"Autoread when changes are from outside
set autoread

"Make <BACKSPACE> works
set backspace=indent,eol,start

"Only highlight number when `cursorline` is on
set cursorlineopt=number

"I don't like history
set history=0

"Highlight when finished search
set hlsearch

"Ignorecase
set ignorecase

"Highlight while search
set incsearch

"Good performence boost
set lazyredraw

"Don't auto load plugins
set noloadplugins

"Show the matching parent
set matchtime=0

"Don't check set() command
set nomodeline

"Don't use more() format
set nomore

"Set `numberwidth` to 2
set numberwidth=2

"Don't allow :autocmd, shell and write commands
set secure

"Set <TAB> to 4 spaces
set shiftwidth=4
set softtabstop=4
set tabstop=4

"When a bracket is inserted, briefly jump to the matching one
set showmatch

"Make cursor always at the middle of the screen
set sidescrolloff=999
set scrolloff=999

"Always splitright
set splitright

"Don't create `swapfile`
set noswapfile

"Timeout
set notimeout
set ttimeout
set ttimeoutlen=0

"Make data store in `viminfo` as least as possible
set viminfo='0,:0,<0,@0,f0

"Autocomplete
set wildignorecase
set wildmenu
set wildmode=list

"Don't wrap
set nowrap

"Disable auto commenting on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"Auto remove trailing whitespaces
autocmd BufWritePre * :%s/\s\+$//e

"Don't show status
let s:hidden_all = 0
function! ToggleHiddenAll()
	if s:hidden_all == 0
		let s:hidden_all = 1
		set noruler
		set laststatus=0
		set nocursorline
		set nonumber
	else
		let s:hidden_all = 0
		set ruler
		set laststatus=2
		set cursorline
		set number
    endif
endfunction
call ToggleHiddenAll()

"Toggle status
noremap <silent> <leader>hh :call ToggleHiddenAll()<CR>

"Disable arrow keys
noremap <up> <Nop>
noremap <down> <Nop>
noremap <left> <Nop>
noremap <right> <Nop>

" `colemak` style movement
noremap <silent> n h
noremap <silent> e gj
noremap <silent> i gk
noremap <silent> o l
noremap j <Nop>

"Keys get overwrite by `colemak`
noremap <silent> h i
noremap <silent> l n
noremap <silent> k o
noremap <silent> H I
noremap <silent> L N
noremap <silent> K O

"Move up and down
noremap <silent> E 10gj
noremap <silent> I 10gk

"`EOL' and `SOL'
noremap <silent> $ g$
noremap <silent> 0 g0

"Use <leader><space> to clear highlighting
noremap <silent> <leader><space> :noh<CR>

"Toggle wrap
noremap <silent> <leader>ww :set wrap!<CR>

"Source `.vimrc`
noremap <silent> <leader>sc :source $HOME/.vimrc<CR>
