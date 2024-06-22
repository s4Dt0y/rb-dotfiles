return {
	"ThePrimeagen/harpoon",
	dependencies = { { "nvim-lua/plenary.nvim" } },
	config = function()
		local harpoon = require("harpoon")
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		harpoon.setup({})

		local keymap = vim.keymap

		keymap.set("n", "<leader>mm", function()
			mark.add_file()
		end, { desc = "Mark file" })

		keymap.set("n", "<leader>mt", function()
			ui.toggle_quick_menu()
		end, { desc = "Toggle Mark Menu" })

		keymap.set("n", "<leader>mn", function()
			ui.nav_next()
		end, { desc = "Next Mark" })

		keymap.set("n", "<leader>mp", function()
			ui.nav_prev()
		end, { desc = "Previous Mark" })
	end,
}
