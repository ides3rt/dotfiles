"Source vim's plugins
source /usr/share/vim/vim82/plugin/getscriptPlugin.vim
source /usr/share/vim/vim82/plugin/gzip.vim
source /usr/share/vim/vim82/plugin/logiPat.vim
source /usr/share/vim/vim82/plugin/manpager.vim
source /usr/share/vim/vim82/plugin/matchparen.vim
source /usr/share/vim/vim82/plugin/netrwPlugin.vim
source /usr/share/vim/vim82/plugin/rrhelper.vim
source /usr/share/vim/vim82/plugin/spellfile.vim
source /usr/share/vim/vim82/plugin/tarPlugin.vim
source /usr/share/vim/vim82/plugin/tohtml.vim
source /usr/share/vim/vim82/plugin/vimballPlugin.vim
source /usr/share/vim/vim82/plugin/zipPlugin.vim

"Disable arrow keys in normal mode
noremap <up> <Nop>
noremap <down> <Nop>
noremap <left> <Nop>
noremap <right> <Nop>

"Disable <space> in visual and normal mode
noremap <space> <Nop>

"I use `colemak` so this is useless
noremap j <Nop>

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
set noloadplugins
set viminfo='0,:0,<0,@0,f0
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

" `colemak` style movement
noremap <silent> n h
noremap <silent> e gj
noremap <silent> i gk
noremap <silent> o l

"Important keys get overwrite by `colemak` so let's change them
noremap <silent> h i
noremap <silent> l n
noremap <silent> k o
noremap <silent> H I
noremap <silent> L N
noremap <silent> K O

" EOL and SOL
noremap <silent> $ g$
noremap <silent> 0 g0

"I move so much quicker
noremap <silent> N 10h
noremap <silent> E 10gj
noremap <silent> I 10gk
noremap <silent> O 10l

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

"Source .vimrc
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
