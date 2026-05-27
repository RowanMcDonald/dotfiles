return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre" },
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "lua", "vim", "vimdoc", "javascript", "typescript", "python", "ruby", "html" },
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
				},
			})
		end,
	},
}
