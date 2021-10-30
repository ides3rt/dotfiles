"Plugins
set noloadplugins

"Disable arrow keys in normal mode
noremap <up> <Nop>
noremap <down> <Nop>
noremap <left> <Nop>
noremap <right> <Nop>

"Disable <space> in visual and normal mode
noremap <space> <Nop>

"I use `dvorak` so this is usoless
noremap h <Nop>
noremap j <Nop>
noremap k <Nop>
noremap l <Nop>

"Use <space> as my <leader>
let mapleader=" "

"Make Tab size to 4 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set nosmarttab
set noexpandtab

"Ignore case
set ignorecase

"Search
set incsearch
set hlsearch
set magic

"Make vim not annoying
set noerrorbells
set novisualbell
set noconfirm
set noautowrite
set noautowriteall
set autoread

"Disable annoying file
set nobackup
set nowritebackup
set noswapfile
set noundofile

"Syntax and Filetype
syntax enable
filetype on
filetype plugin on
filetype indent off

"Indent
set autoindent
set nosmartindent
set nobreakindent
set nocopyindent

"Disable wrap
set nowrap
set wrapmargin=0
set wrapscan

"Make screen always move
set sidescrolloff=999
set scrolloff=999
set nomore

"Autocompletion
set wildchar=<Tab>
set wildignorecase
set wildmenu
set wildmode=list

"Formating
set fileformat=unix
set encoding=utf-8
set t_Co=256

"Split
set splitright
set equalalways

"Make vim not weird
set nocompatible
set noedcompatible
set secure
set backspace=indent,eol,start
set esckeys
set nohidden
set nospell
set noopendevice
set remap
set norevins
set norightleft
set noscrollbind
set scrolljump=1
set noshiftround

" `dvorak` style movement
noremap <silent> h h
noremap <silent> t gj
noremap <silent> n gk
noremap <silent> s l

" EOL and SOL
noremap <silent> $ g$
noremap <silent> 0 g0

"I move so much quicker
noremap <silent> H 10h
noremap <silent> T 10gj
noremap <silent> N 10gk
noremap <silent> S 10l

"Disable automatic commenting on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"Automatic remove trailing whitespaces
autocmd BufWritePre * :%s/\s\+$//e

"Use <leader><space> to clear highlighting
noremap <silent> <leader><space> :noh<CR>

"Toogle relativenumber
noremap <silent> <leader>nn :set relativenumber!<CR>

"Toggle wrap
noremap <silent> <leader>ww :set wrap!<CR>

noremap <silent> <leader>sc :source $HOME/.vimrc<CR>

"Timing
set notimeout
set ttimeout
set ttimeoutlen=0
set matchtime=0

"Make vim show some status
set showmode
set ruler
set showcmd
set prompt
set noshortname
set showfulltag
set showmatch
set nowriteany

"Make things look a lots cleaner
set nomodeline
set history=0
set laststatus=0
set notitle
set nocursorline
set cmdheight=1
set nonumber
set norelativenumber
set numberwidth=4
set lazyredraw
set showtabline=1
set writedelay=0
