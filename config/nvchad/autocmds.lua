local autocmd = vim.api.nvim_create_autocmd

autocmd("VimResized", {
	pattern = "*",
	command = "tabdo wincmd =",
})
