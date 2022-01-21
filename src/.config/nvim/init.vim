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
	"Enable syntax highlight
	syntax on

	if !has('gui_running')
		colorscheme ides3rt-v3
		set ttyfast
	endif

	"Only highlight number when `cursorline` is on
	set cursorlineopt=number
endif

" Your <leader>
noremap <space> <Nop>
let mapleader = " "

" Plugins
source $XDG_CONFIG_HOME/nvim/plugin/textwidth.vim
source $XDG_CONFIG_HOME/nvim/plugin/status.vim
source $XDG_CONFIG_HOME/nvim/plugin/syntax.vim

" Change pwd to open file's directory
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
if has('clipboard')
	set clipboard=unnamedplus,unnamed
endif

" Copy existing indent
set copyindent

" Call `fsync` function when write
set fsync

" Don't change my cursor
set guicursor=

" Disable ':' history
set history=0

if has('extra_search')
	" Highlight search
	set hlsearch

	" Highlight while search
	if has('reltime')
		set incsearch
	endif

	"Use <leader><space> to clear highlighting
	nnoremap <silent> <leader><space> :noh<CR>
endif

" Case insensitive
set ignorecase

" No double <SPACE> after period
set nojoinspaces

" It's only enable for backwards compatibility
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

" Show the matching parent
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

" I don't like to have '/usr/include'
set path=**

" Don't allow :autocmd, shell, and write commands
set secure

" Make DOS compatible with Unix [nvim(1) defaults]
if has('mksession')
	set sessionoptions=blank,buffers,curdir,folds,help,tabpages,slash,winsize,terminal,unix
	set viewoptions=folds,cursor,slash,unix,curdir
endif

" Set <TAB> to 4 spaces
set nosmarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Disable some verbosity
set shortmess=filnxtToOFS

" Don't show commands [vim(1) default]
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

" Don't move cursor to sol [nvim(1) default]
set nostartofline

" Don't create 'swapfile'
set noswapfile

" Textwidth
set textwidth=80

" Timeout
set notimeout
set ttimeout
set ttimeoutlen=0

" Ignore case when auto complete
set wildignorecase

" Use menu auto-complete
if has('wildmenu')
	set wildmenu
endif

" Don't wrap
set nowrap

" Disable auto-comment on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

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

" Source vimrc
nnoremap <silent> <leader>rc :source $XDG_CONFIG_HOME/nvim/init.vim<CR>
