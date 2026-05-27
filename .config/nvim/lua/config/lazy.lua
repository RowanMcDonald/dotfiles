local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Set leader key (must be before lazy.nvim)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- emmet config
vim.g.user_emmet_leader_key = ","

-- quick-scope
vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
-- vim.g.qs_enable = 0

-- vim.opt.shadafile = "NONE"
vim.opt.number = false -- Show line numbers
vim.opt.relativenumber = false -- Show relative line numbers
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 2 -- Size of an indent
vim.opt.tabstop = 2 -- Number of spaces tabs count for
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.wrap = false -- Disable line wrap
vim.opt.termguicolors = true -- True color support
vim.opt.showmode = false
vim.opt.swapfile = false
vim.opt.confirm = true
vim.opt.hidden = true
vim.opt.autoindent = true
vim.opt.clipboard:append("unnamedplus")

vim.opt.wildmode = "longest:full,full"

vim.opt.wildignore:append({
	"*.a",
	"*.o",
	"*.bmp",
	"*.gif",
	"*.ico",
	"*.jpg",
	"*.png",
	".DS_Store",
	".git",
	".hg",
	".svn",
	"*~",
	"*.swp",
	"*.tmp",
	"node_modules/*",
})
vim.opt.hlsearch = false

require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "onedark" } },

	-- automatically check for plugin updates
	checker = { enabled = false },
})
