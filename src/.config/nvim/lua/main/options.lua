local set = vim.opt

vim.cmd [[
	autocmd FileType * setlocal formatoptions-=ro
	autocmd BufWritePre * :%s/\s\+$//e
]]

if os.getenv("DISPLAY") ~= nil then
	set.clipboard = { "unnamedplus", "unnamed" }
end

if os.getenv("UID") == 0 then
	set.listchars = "tab:<->,trail:~"
else
	set.listchars = "tab:<─>,trail:~"
end

set.complete:append { "kspell" }
set.diffopt:append { "vertical" }
set.shortmess:append "cS"

set.autochdir = true
set.path = { "**" }

set.shada = { "" }
set.swapfile = false

set.fsync = true
set.lazyredraw = true

set.breakindent = true
set.textwidth = 100
set.wrap = false
set.virtualedit = { "block" }

set.timeout = false
set.ttimeout = true
set.ttimeoutlen = 0

set.ignorecase = true
set.wildignorecase = true

set.sidescroll = 0
set.sidescrolloff = 999
set.scrolloff = 999

set.expandtab = true
set.shiftwidth = 4
set.softtabstop = 4
set.tabstop = 4

set.cursorlineopt = { "number" }
set.numberwidth = 2

set.showcmd = false
set.modeline = false
set.modelines = 0
set.more = false

set.showmatch = true
set.matchtime = 0

set.splitbelow = true
set.splitright = true
