require("sadtoy.core.options")
require("sadtoy.core.keymaps")
require("sadtoy.core.client-server")
require("sadtoy.lazy")

if vim.g.neovide then
	require("sadtoy.core.neovide")
end

vim.cmd("colorscheme sonokai")
vim.cmd("nnoremap <A-H> <C-O>")
