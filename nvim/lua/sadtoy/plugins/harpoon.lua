return {
	"ThePrimeagen/harpoon",
	config = function()
		require("harpoon").setup({
			tabline = false,
		})

		local keymap = vim.keymap
		keymap.set("n", "<leader>mm", '<cmd>lua require("harpoon.mark").add_file()<CR>', { desc = "Mark file" })
		keymap.set(
			"n",
			"<leader>mt",
			'<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>',
			{ desc = "Toggle Mark Menu" }
		)
		keymap.set("n", "<leader>mn", '<cmd>lua require("harpoon.ui").nav_next()<CR>', { desc = "Next Mark" })
		keymap.set("n", "<leader>mp", '<cmd>lua require("harpoon.ui").nav_prev()<CR>', { desc = "Previous Mark" })
	end,
}
