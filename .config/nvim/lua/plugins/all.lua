return {
	{ "tpope/vim-projectionist", event = "VeryLazy" },
	-- { "tpope/vim-sensible" },
	{ "mattn/emmet-vim", event = "VeryLazy" },

	-- {
	-- 	"nvimdev/lspsaga.nvim",
	-- 	config = function()
	-- 		require("lspsaga").setup({})
	-- 	end,
	-- },

	{
		"razak17/tailwind-fold.nvim",
		event = "VeryLazy",
		opts = {},
		ft = { "html", "svelte", "astro", "vue", "typescriptreact", "php", "blade", "eruby" },
	},
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({
				theme = "hyper",
				config = {
					project = {
						icon = "",
					},
					mru = {
						cwd_only = true,
					},
					packages = { enable = true },
					week_header = {
						enable = true,
					},
					shortcut = {},
					footer = {},
				},
				-- config
			})
		end,
		-- dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},

	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {
			skip_confirm_for_simple_edits = true,
			keymaps = {
				["<C-l>"] = false,
				["<C-p>"] = false,
			},
		},
		-- Optional dependencies
		-- dependencies = { { "echasnovski/mini.icons", opts = {} } },
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,
	},

	{ "unblevable/quick-scope", event = "VeryLazy" },
	-- {
	-- 	"dstein64/vim-startuptime",
	-- 	-- lazy-load on a command
	-- 	cmd = "StartupTime",
	-- 	-- init is called during startup. Configuration for vim plugins typically should be set in an init function
	-- 	init = function()
	-- 		vim.g.startuptime_tries = 10
	-- 	end,
	-- },

	-- Treesitter for better syntax highlighting
	{ "tpope/vim-rails", event = "VeryLazy" },

	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				icons_enabled = false,
				component_separators = "",
				section_separators = { left = " ", right = " " },
			},
			sections = {
				lualine_a = { { "mode", right_padding = 2 } },
				lualine_b = { "filename", "branch" },
				lualine_c = {
					"%=", --[[ add your center components here in place of this comment ]]
				},
				lualine_x = {},
				lualine_y = { "filetype" },
				lualine_z = {
					{ "location", left_padding = 2 },
				},
			},
			inactive_sections = {
				lualine_a = { "filename" },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = { "filetype" },
				lualine_z = { "location" },
			},
			tabline = {},
			extensions = {},
		},
	},

	-- Comment toggling
	-- {
	-- 	"numToStr/Comment.nvim",
	-- 	opts = {
	-- 		-- add any options here
	-- 	},
	-- },

	-- LSP Support
	{ "neovim/nvim-lspconfig" },

	{
		"saghen/blink.cmp",
		event = "InsertEnter",
		-- optional: provides snippets for the snippet source

		-- use a release tag to download pre-built binaries
		version = "1.*",
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
			keymap = { preset = "default" },

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			-- (Default) Only show the documentation popup when manually triggered
			completion = {
				documentation = { auto_show = false },
				ghost_text = { enabled = true },
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- See the fuzzy documentation for more information
			fuzzy = { implementation = "prefer_rust_with_warning" },
			keymap = {
				preset = "super-tab",
			},
		},
		opts_extend = { "sources.default" },
		dependencies = { "rafamadriz/friendly-snippets" },
	},

	-- { "hwartig/vim-seeing-is-believing" },

	{
		"stevearc/conform.nvim",
		event = "VeryLazy",
		cmd = { "ConformInfo" },
		keys = {
			{
				-- Customize or remove this keymap to your liking
				"<leader>f",
				function()
					require("conform").format({ async = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		-- This will provide type hinting with LuaLS
		---@module "conform"
		---@type conform.setupOpts
		opts = {
			-- Define your formatters
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				go = { "goimports", "gofmt" },
				ruby = { "rubyfmt" },
				java = { "google-java-format" },
				["_"] = { "trim_whitespace", lsp_format = "prefer" },
			},
			-- Set default options
			default_format_opts = {
				lsp_format = "fallback",
			},
			-- Set up format-on-save
			format_on_save = { timeout_ms = 500 },
			-- Customize formatters
			formatters = {
				shfmt = {
					append_args = { "-i", "2" },
				},
			},
		},
		init = function()
			-- If you want the formatexpr, here is the place to set it
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
}
