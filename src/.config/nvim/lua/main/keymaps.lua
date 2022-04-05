vim.g.mapleader = " "

local function map(mode, shortcut, command)
	vim.api.nvim_set_keymap(
		mode, shortcut, command,
		{ noremap = true, silent = true }
	)
end

map("", "j", "gj")
map("", "k", "gk")

map("", "<leader>ac", ":center<CR>")
map("", "<leader>ar", ":right<CR>")
map("", "<leader>al", ":left<CR>")

map("n", "<leader>nn", ":next<CR>")
map("n", "<leader>pp", ":prev<CR>")

map("n", "<leader>ic", ":set ignorecase!<CR>")
map("n", "<leader>ls", ":set list!<CR>")
map("n", "<leader>sw", ":set wrap! linebreak!<CR>")
map("n", "<leader><space>", ":noh<CR>")

map("n", "Y", "y$")

map("n", "Q", "<Nop>")
map("n", "gQ", "<Nop>")
map("n", "q:", "<Nop>")
