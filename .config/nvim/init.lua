require("config.lazy")

-- Setup lazy.nvim and configure plugins

-- Example key mappings
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>l", ":Lazy<CR>", { desc = "Open Lazy plugin manager" })

-- oil mimicing vim-vinegar
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Window navigation mappings
vim.keymap.set("n", "<C-J>", "<C-W><C-J>", { desc = "Move to window below" })
vim.keymap.set("n", "<C-K>", "<C-W><C-K>", { desc = "Move to window above" })
vim.keymap.set("n", "<C-L>", "<C-W><C-L>", { desc = "Move to window right" })
vim.keymap.set("n", "<C-H>", "<C-W><C-H>", { desc = "Move to window left" })

-- LSP Configs
vim.lsp.enable("rust_analyzer")

vim.lsp.enable("ruby_lsp")
vim.lsp.config("ruby_lsp", {
	init_options = {
		formatter = "rubyfmt",
	},
})
vim.lsp.enable("tailwindcss")

vim.keymap.set("n", "gt", "<C-W><C-]>", { desc = "Go to tag under cursor" })

vim.diagnostic.config({
	signs = false,
	virtual_text = false, -- Keep inline diagnostics if wanted
	underline = false, -- Keep underlines if wanted
})

-- Basic settings

-- seeing is believing
-- Create augroup
-- local augroup = vim.api.nvim_create_augroup("seeingIsBelievingSettings", { clear = true })

-- Ruby-specific mappings
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "ruby",
-- 	group = augroup,
-- 	callback = function()
-- 		local opts = { buffer = true, remap = true }
--
-- 		-- Enter mappings
-- 		vim.keymap.set("n", "<Enter>", "<Plug>(seeing-is-believing-mark-and-run)", opts)
-- 		vim.keymap.set("x", "<Enter>", "<Plug>(seeing-is-believing-mark-and-run)", opts)
--
-- 		-- F4 mappings
-- 		vim.keymap.set("n", "<F4>", "<Plug>(seeing-is-believing-mark)", opts)
-- 		vim.keymap.set("x", "<F4>", "<Plug>(seeing-is-believing-mark)", opts)
-- 		vim.keymap.set("i", "<F4>", "<Plug>(seeing-is-believing-mark)", opts)
--
-- 		-- F5 mappings
-- 		vim.keymap.set("n", "<F5>", "<Plug>(seeing-is-believing-run)", opts)
-- 		vim.keymap.set("i", "<F5>", "<Plug>(seeing-is-believing-run)", opts)
-- 	end,
-- })

vim.keymap.set("n", "<C-p>", ":Telescope find_files<cr>", { silent = true })

-- projectionist
vim.g.rails_projections = {
	["app/controllers/*_controller.rb"] = {
		test = {
			"spec/requests/{}_spec.rb",
			"spec/requests/{}_controller_spec.rb",
			"spec/controllers/{}_controller_spec.rb",
			"test/controllers/{}_controller_test.rb",
		},
		alternate = {
			"spec/requests/{}_spec.rb",
			"spec/requests/{}_controller_spec.rb",
			"spec/controllers/{}_controller_spec.rb",
			"test/controllers/{}_controller_test.rb",
		},
	},
	["spec/requests/*_spec.rb"] = {
		command = "request",
		alternate = "app/controllers/{}_controller.rb",
		template = 'require "rails_helper"\n\n' .. 'RSpec.describe "{}" do\nend',
	},
	["app/models/*.rb"] = {
		affinity = "model",
		alternate = {
			"spec/models/{}_spec.rb",
		},
		template = { "class {camelcase|capitalize|colons}", "end" },
		type = "model",
	},
	["spec/models/*_spec.rb"] = {
		affinity = "model",
		template = {
			'require "rails_helper"',
			"",
			"RSpec.describe {camelcase|capitalize|colons} do",
			"  subject {open} described_class.new {close}",
			"",
			'  describe "validations" do',
			'    it "adds an error..." do',
			"    end",
			"  end",
			"",
			'  describe "#save!" do',
			'    it "saves x..." do',
			"    end",
			"  end",
			"end",
		},
		type = "unit test",
	},
	["spec/jobs/*_spec.rb"] = {
		affinity = "model",
		template = {
			'require "rails_helper"',
			"",
			"RSpec.describe {camelcase|capitalize|colons} do",
			"  subject {open} described_class.new {close}",
			"",
			'  describe "perform" do',
			'    it "adds does xyz..." do',
			"      expect {open}",
			"        subject.perform",
			"      {close}.to change {}.from().to()",
			"    end",
			"  end",
			"end",
		},
		type = "unit test",
	},
}

-- Disable deprecations
vim.deprecate = function() end
