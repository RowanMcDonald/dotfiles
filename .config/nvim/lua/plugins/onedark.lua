return {
	-- Colorscheme
	{
		"navarasu/onedark.nvim",
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			vim.cmd([[colorscheme onedark]])
			-- require("onedark").setup({
			-- 	style = "dark",
			-- })
			-- -- Enable theme
			-- require("onedark").load()
		end,
	},
}
