return {
	"ThePrimeagen/harpoon",
	config = function()
		local keymap = vim.keymap
		keymap.set("n", "<leader>mm", '<cmd>lua require("harpoon.mark").add_file()<CR>', { desc = "Mark file" })
		keymap.set(
			"n",
			"<leader>mt",
			'<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>',
			{ desc = "Toggle Mark Menu" }
		)
		keymap.set("n", "<leader>ml", '<cmd>lua require("harpoon.ui").nav_next()<CR>', { desc = "Next Mark" })
		keymap.set("n", "<leader>mh", '<cmd>lua require("harpoon.ui").nav_prev()<CR>', { desc = "Previous Mark" })
	end,
}
