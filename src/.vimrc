"Change vim() PATH
set runtimepath=$HOME/.config/vim,$VIM/vimfiles,$VIMRUNTIME

"Syntax and Filetype
if has('syntax')
	"Enable syntax highlight
	syntax on
	filetype on

	if !has('gui_running')
		colorscheme ides3rt
		set ttyfast
	endif

	"Only highlight number when `cursorline` is on
	set cursorlineopt=number
endif

"Use <space> as my <leader>
noremap <space> <Nop>
let mapleader=" "

"Plugins variables
let g:Status = 0
let g:Textwidth = 1

"Plugins
source $HOME/.config/vim/plugin/colemak.vim
source $HOME/.config/vim/plugin/status.vim
source $HOME/.config/vim/plugin/textwidth.vim

"Indent
set autoindent

"Autoread when changes are from outside
set autoread

"Make <BACKSPACE> works
set backspace=indent,eol,start

"Copy existing indent
set copyindent

"Disable `:' history
set history=0

if has('extra_search')
	"Highlighted search
	set hlsearch

	"Highlight while search
	if has('reltime')
		set incsearch
	endif

	"Use <leader><space> to clear highlighting
	noremap <silent> <leader><space> :noh<CR>
endif

"Ignorecase
set ignorecase

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
if has('linebreak')
	set numberwidth=2
endif

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
if has('viminfo')
	set viminfo='0,:0,<0,@0,f0
endif

"Ignorecase when auto complete
set wildignorecase

"Use menu autocomplete
if has('wildmenu')
	set wildmenu
endif

"Don't wrap
set nowrap

"Disable auto commenting on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"Auto remove trailing whitespaces
autocmd BufWritePre * :%s/\s\+$//e

"Disable arrow keys
noremap <up> <Nop>
noremap <down> <Nop>
noremap <left> <Nop>
noremap <right> <Nop>

"Toggle `ignorecase`
noremap <silent> <leader>ii :set ignorecase!<CR>

"Toggle wrap
noremap <silent> <leader>ww :set wrap!<CR>

"Center-, right-, or left-align one or more lines
noremap <silent> <leader>ac :center<CR>
noremap <silent> <leader>ar :right<CR>
noremap <silent> <leader>al :left<CR>

"When you open multiple files
noremap <silent> <leader>nn :next<CR>
noremap <silent> <leader>pp :prev<CR>

"Source `.vimrc`
noremap <silent> <leader>rc :source $HOME/.vimrc<CR>
