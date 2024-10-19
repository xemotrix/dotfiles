-- vim: ts=2 sts=2 sw=2 et
vim.cmd([[
    command W w
    command Q q
    command Wq wq
    command WQ wq
]])

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ Setting options ]]
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 100
-- vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.hlsearch = true
vim.opt.wrap = false

-- [[ Basic Keymaps ]]
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<leader>bc", ":bw<CR>")
vim.keymap.set("n", "<leader>bo", ":%bd\\|e#\\|bd#<CR>")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "n", "nzz")
vim.keymap.set("v", "N", "Nzz")
vim.keymap.set("x", "<leader>p", '"_dP')
vim.keymap.set("x", "<leader>p", '"_dP')
-- Diagnostic keymaps
vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>a", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Keybinds to make split navigation easier.
vim.keymap.set("n", "<Left>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<Right>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<Down>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<Up>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- "macros"
-- sort paragraph
vim.keymap.set("n", "<leader>S", "vip:'<,'>sort<CR>", { desc = "Sort paragraph" })

-- profiling
vim.api.nvim_create_user_command("ProfileStart", function(_)
	vim.cmd(":profile start profile.log")
	vim.cmd(":profile func *")
	vim.cmd(":profile file *")
end, { nargs = "?" })

vim.api.nvim_create_user_command("ProfileStop", function(_)
	vim.cmd(":profile stop")
end, { nargs = "?" })

-- [[ Basic Autocommands ]]
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 50 })
	end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require("lazy").setup({
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("kanagawa")
		end,
	},
	"rhysd/vim-llvm",
	"folke/trouble.nvim",
	"stevearc/oil.nvim",
	"jlanzarotta/bufexplorer",
	"lewis6991/gitsigns.nvim",
	"michaeljsmith/vim-indent-object",
	"ThePrimeagen/harpoon",
	"junegunn/vim-easy-align",
	"lewis6991/gitsigns.nvim",
	"tpope/vim-commentary",
	"tpope/vim-sleuth",
	"tpope/vim-surround",
	"rcarriga/nvim-notify",
	"kana/vim-textobj-user",
	"neovimhaskell/nvim-hs.vim",
	"isovector/cornelis",
	{
		"Julian/lean.nvim",
		event = { "BufReadPre *.lean", "BufNewFile *.lean" },
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-lua/plenary.nvim",
		},
		opts = {
			init_options = {
				editDelay = 0,
				hasWidgets = true,
			},
			mappings = true,

			infoview = {
				autoopen = true,
				horizontal_position = "bottom",
				separate_tab = false,
				indicators = "auto",
			},
			progress_bars = {
				enable = true,
				character = "│",
				priority = 10,
			},
		},
	},
	"github/copilot.vim",
	-- "supermaven-inc/supermaven-nvim",
	{
		"nvimdev/lspsaga.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"maxandron/goplements.nvim",
		ft = "go",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = "all",
			sync_install = false,
			auto_install = true,
			ignore_install = { "norg" },
			highlight = {
				enable = true,
				disable = { "go" },
			},
		},
	},
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gg", ":Git <CR>")
		end,
	},
	{
		"mbbill/undotree",
		config = function()
			vim.cmd([[
      let g:undotree_WindowLayout = 1
      nnoremap <leader>u :UndotreeToggle<CR>
      ]])
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-tree/nvim-web-devicons" },
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false, -- REQUIRED: tell lazy.nvim to start this plugin at startup
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "ms-jpq/coq_nvim", branch = "coq" },
			{ "ms-jpq/coq.artifacts", branch = "artifacts" },
			{ "ms-jpq/coq.thirdparty", branch = "3p" },
		},
		init = function()
			vim.g.coq_settings = {
				auto_start = "shut-up", -- if you want to start COQ at startup
				display = {
					preview = {
						border = "double",
					},
				},
				keymap = {
					manual_complete = "<C-c>",
					pre_select = true,
					jump_to_mark = "<C-;>",
				},
			}
		end,
	},
	{ -- Autoformat
		"stevearc/conform.nvim",
		opts = {
			notify_on_error = false,
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				lua = { "stylua" },
			},
		},
	},
	{
		"roobert/tailwindcss-colorizer-cmp.nvim",
		-- optionally, override the default options:
		config = function()
			require("tailwindcss-colorizer-cmp").setup({
				color_square_width = 2,
			})
		end,
	},
})
