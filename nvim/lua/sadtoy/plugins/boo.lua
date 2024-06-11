return {
	"LukasPietzschmann/boo.nvim",
	opts = {
		-- here goes your config :)
	},
	config = function()
		require("boo").setup({})
		vim.keymap.set("n", "<leader>b", function()
			require("boo").boo()
		end, { desc = "LSP Info" })
	end,
}
