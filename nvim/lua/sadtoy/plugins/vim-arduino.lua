return {
	"stevearc/vim-arduino",
	config = function()
		local keymap = vim.keymap
		keymap.set("n", "<cmd>ArduinoAttach<CR>", "<leader>aa", { desc = "Automatically attach to your board" })
		keymap.set("n", "<cmd>ArduinoVerify<CR>", "<leader>av", { desc = "Compile" })
		keymap.set("n", "<cmd>ArduinoUpload<CR>", "<leader>au", { desc = "Upload" })
		keymap.set(
			"n",
			"<cmd>ArduinoUploadAndSerial<CR>",
			"<leader>aus",
			{ desc = "Build, upload, and connect for debugging" }
		)
		keymap.set("n", "<cmd>ArduinoSerial<CR>", "<leader>as", { desc = "Connect for debugging" })
		keymap.set("n", "<cmd>ArduinoChooseBoard<CR>", "<leader>ab", { desc = "Choose board" })
		keymap.set("n", "<cmd>ArduinoChooseProgrammer", "<leader>ap", { desc = "Choose programmer" })
	end,
}
