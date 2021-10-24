"Plugins
set noloadplugins

"Disable arrow keys
nnoremap <up> <Nop>
nnoremap <down> <Nop>
nnoremap <left> <Nop>
nnoremap <right> <Nop>
vnoremap <up> <Nop>
vnoremap <down> <Nop>
vnoremap <left> <Nop>
vnoremap <right> <Nop>

"Disable <space>
nnoremap <space> <Nop>
vnoremap <space> <Nop>

"Disable h
nnoremap h <Nop>
vnoremap h <Nop>

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

"Use {j,k,l,;} instead of {h,j,k,l}
nnoremap <silent> j h
nnoremap <silent> k gj
nnoremap <silent> l gk
nnoremap <silent> ; l
vnoremap <silent> j h
vnoremap <silent> k gj
vnoremap <silent> l gk
vnoremap <silent> ; l

"Use {K,L} instead of 10{j,k}
nnoremap <silent> K 10gj
nnoremap <silent> L 10gk
vnoremap <silent> K 10gj
vnoremap <silent> L 10gk

"Use ^ to go to `sol`
nnoremap <silent> ^ 0
vnoremap <silent> ^ 0

"Disable automatic commenting on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"Automatic remove trailing whitespaces
autocmd BufWritePre * :%s/\s\+$//e

"Use <leader><space> to clear highlighting
nnoremap <silent> <leader><space> :noh<CR>

"Enable/Disable number
nnoremap <silent> <leader>rn :set relativenumber!<CR>

"Use :W to sudo/doas save the file
command! W execute 'w !doas tee % > /dev/null' <Bar> edit!

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
