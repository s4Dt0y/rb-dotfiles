return {
	{
		"folke/tokyonight.nvim",
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("tokyonight").setup({
				style = "night",
				transparent = "true",
				styles = {
					comments = { italic = true },
					keywords = { italic = true },
					sidebars = "transparent", -- style for sidebars, see below
					floats = "transparent", -- style for floating windows
				},
			})
			-- load the colorscheme here
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
}
