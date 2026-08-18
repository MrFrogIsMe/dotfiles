return {
	-- Pin fzf-lua near LazyVim's fzf extra commit date to fix
	-- ":CopilotChatModels" crash (fzf_opts nil in LazyVim fzf.lua ui_select)
	{ "ibhagwan/fzf-lua", commit = "988416cc782dfe28bff3f0da9b8c943b236cd86a" },

	-- Theme
	"morhetz/gruvbox",
	"joshdick/onedark.vim",
	"olimorris/onedarkpro.nvim",
	"xiyaowong/transparent.nvim",
	{ "catppuccin/nvim", as = "catppuccin" },

	-- -- Telescope
	-- {
	-- 	"nvim-telescope/telescope.nvim",
	-- 	tag = "*",
	-- 	-- or                            , branch = '0.1.x',
	-- 	dependencies = { { "nvim-lua/plenary.nvim" } },
	-- },

	-- -- Sidebars
	-- {
	-- 	"nvim-tree/nvim-tree.lua",
	-- 	dependencies = {
	-- 		"nvim-tree/nvim-web-devicons", -- optional, for file icons
	-- 	},
	-- 	-- tag = 'nightly' -- optional, updated every week. (see issue #1193)
	-- },
	-- "stevearc/aerial.nvim",
	-- -- 'simrat39/symbols-outline.nvim',

	-- -- Lines
	-- { "akinsho/bufferline.nvim", tag = "*", dependencies = "nvim-tree/nvim-web-devicons" },
	-- { "justinhj/battery.nvim", dependencies = { { "nvim-tree/nvim-web-devicons" }, { "nvim-lua/plenary.nvim" } } },

	-- -- Pair
	-- {
	-- 	"windwp/nvim-autopairs",
	-- 	-- event = "InsertEnter",
	-- },

	-- -- Folds
	-- { "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },

	-- -- Debug
	-- { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
	-- "theHamsta/nvim-dap-virtual-text",

	-- -- Formater
	-- "nvim-lua/plenary.nvim",
	-- "nvimtools/none-ls.nvim",
	-- "MunifTanjim/prettier.nvim",

	-- AI auto-complete
	{
		"zbirenbaum/copilot.lua",
		-- cmd = "Copilot",
		-- event = "InsertEnter",
	},
	-- {
	-- 	"CopilotC-Nvim/CopilotChat.nvim",
	-- 	dependencies = {
	-- 		{ "zbirenbaum/copilot.lua" }, -- or zbirenbaum/copilot.lua
	-- 		{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
	-- 	},
	-- },

	-- -- nvim-cmp
	-- "hrsh7th/cmp-nvim-lsp", -- { name = nvim_lsp }
	-- "hrsh7th/cmp-buffer", -- { name = 'buffer', },
	-- "hrsh7th/cmp-path", -- { name = 'path', }
	-- "hrsh7th/cmp-cmdline", -- { name = 'cmdline', }
	-- "hrsh7th/nvim-cmp",
	-- "hrsh7th/cmp-nvim-lsp-signature-help",
	-- -- vsnip
	-- "hrsh7th/cmp-vsnip", -- { name = 'vsnip', }
	-- "hrsh7th/vim-vsnip",
	-- -- luasnip
	-- "L3MON4D3/LuaSnip",
	-- -- 'saadparwaiz1/cmp_luasnip',

	-- -- Color Preview
	-- "brenoprata10/nvim-highlight-colors",
	-- "norcalli/nvim-colorizer.lua",

	-- -- lspkind
	-- "onsails/lspkind-nvim",

	-- -- Markdown
	-- {
	-- 	"iamcco/markdown-preview.nvim",
	-- 	build = "cd app && npm install",
	-- 	setup = function()
	-- 		vim.g.mkdp_filetypes = { "markdown" }
	-- 	end,
	-- 	ft = { "markdown" },
	-- },

	-- -- LaTex
	-- "lervag/vimtex",

	-- -- Golf.vim
	-- "vuciv/golf",

	-- -- -- Pets.nvim
	-- -- {
	-- --   "giusgad/pets.nvim",
	-- --   dependencies = {
	-- --     "giusgad/hologram.nvim",
	-- --     "MunifTanjim/nui.nvim",
	-- --   }
	-- -- },
	--
	-- -- -- Duck.nvim
	-- -- {
	-- --   'tamton-aquib/duck.nvim',
	-- --   config = function()
	-- --       vim.keymap.set('n', '<leader>dd', function() require("duck").hatch("🐕") end, {})
	-- --       vim.keymap.set('n', '<leader>dk', function() require("duck").cook() end, {})
	-- --       vim.keymap.set('n', '<leader>da', function() require("duck").cook_all() end, {})
	-- --   end
	-- -- },
}
