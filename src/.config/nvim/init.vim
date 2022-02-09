" Prepare XDG
if !exists('$XDG_CONFIG_HOME')
	let $XDG_CONFIG_HOME = "$HOME/.config"
endif

" Detecting file type
filetype on
filetype plugin on
filetype indent on

" Syntax
if has('syntax')
	" Enable syntax highlight
	syntax on

	if !has('gui_running')

		" These only work when in TTY
		colorscheme ides3rt-v3
		set ttyfast

		" Don't change my cursor
		set guicursor=

	endif

	" Only highlight number when 'cursorline' is on
	set cursorlineopt=number
endif

" Your <leader>
noremap <space> <Nop>
let mapleader = " "

" Plugins
source $XDG_CONFIG_HOME/nvim/plugin/textwidth.vim
source $XDG_CONFIG_HOME/nvim/plugin/status.vim
source $XDG_CONFIG_HOME/nvim/plugin/syntax.vim

" Change $PWD to the opening file's directory
set autochdir

" Auto-indent
set autoindent

" Auto-read when changes are from outside
set autoread

" Make <BS> works
set backspace=indent,eol,start

" Disable bell
set belloff=all

" Use X-server clipboard
if has('clipboard') && exists("$DISPLAY")
	set clipboard=unnamedplus,unnamed
endif

" Call fsync() when write
set fsync

" Allow to change buffer w/o write
set hidden

" Disable ':' history
set history=0

if has('extra_search')
	" Highlight search
	set hlsearch

	" Immediately jump to search results
	if has('reltime') | set incsearch | endif

	"Use <leader><space> to clear highlighting
	nnoremap <silent> <leader><space> :noh<CR>
endif

" Case insensitive
set ignorecase

" No double <space> after period
set nojoinspaces

" It's only enable for backward compatibility
if has('langmap')
	set nolangnoremap
	set nolangremap
endif

" Good performence boost
set lazyredraw

" When 'list' characters
if expand("$UID") == '0'
    set listchars=tab:<->,trail:~
else
    set listchars=tab:<─>,trail:~
endif
nnoremap <silent> <leader>ls :set list!<CR>

" Don't auto load plugins
set noloadplugins

" Tenths of a second to show the matching paren
set matchtime=0

" Don't check `set` command
set nomodeline

" Don't use `more` format
set nomore

" Set 'nrformats' to recommended values
set nrformats=bin,hex

if has('linebreak')
	" Set 'numberwidth' to 2
	set numberwidth=2

	" When 'linebreak' is set
	set breakindent
endif

" Fuzzy finder
set path=**

" Set <TAB> to 4 spaces
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Don't give 'ins-completion-menu' messages
set shortmess+=cS

" Don't partial show commands
set noshowcmd

" When a bracket is inserted, briefly jump to the matching one
set showmatch

" Make cursor always at the middle of the screen
set sidescroll=0
set sidescrolloff=999
set scrolloff=999

" Always split using alternative side
set splitbelow
set splitright

" Don't move cursor to SOL, when possible
set nostartofline

" Don't create 'swapfile'
set noswapfile

" Textwidth
set textwidth=80

" Timeout
set notimeout
set ttimeout
set ttimeoutlen=0

" Cursor can be positioned everywhere, when in Visual-Block
set virtualedit=block

" Disallow cursor to wrap between lines
set whichwrap=

" Case insensitive when auto-complete
set wildignorecase

" Use menu auto-complete
if has('wildmenu')
	set wildmenu
endif

" Don't wrap
set nowrap

" Disable auto-comment on newline
autocmd FileType * setlocal formatoptions-=ro

" Auto remove trailing whitespaces
autocmd BufWritePre * :%s/\s\+$//e

" For 'wrap' users
noremap <silent> j gj
noremap <silent> k gk

" Disable Ex mode
nnoremap <silent> Q <Nop>
nnoremap <silent> gQ <Nop>
nnoremap <silent> q: <Nop>

" Toggle 'ignorecase'
nnoremap <silent> <leader>ic :set ignorecase!<CR>

" Toggle 'wrap'
nnoremap <silent> <leader>sw :set wrap! linebreak!<CR>

" Center-, right-, or left-align one or more lines
noremap <silent> <leader>ac :center<CR>
noremap <silent> <leader>ar :right<CR>
noremap <silent> <leader>al :left<CR>

" When you open multiple files
nnoremap <silent> <leader>nn :next<CR>
nnoremap <silent> <leader>pp :prev<CR>

" Source (n)vimrc
nnoremap <silent> <leader>rc :source $XDG_CONFIG_HOME/nvim/init.vim<CR>

" Don't allow :autocmd, shell, and write commands
set secure
