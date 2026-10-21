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

vim.o.winborder = "single"

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

-- Keybinds to make split navigation easier.
vim.keymap.set("n", "<Left>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<Right>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<Down>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<Up>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- copy buffer file path to clipboard
vim.keymap.set("n", "<leader>yp", function()
	local path = vim.fn.expand("%:p")
	if path == "" then
		vim.notify("Buffer has no file path", vim.log.levels.WARN)
		return
	end
	vim.fn.setreg("+", path)
end, { desc = "Copy buffer file path to clipboard" })

-- copy buffer file path with line number to clipboard
vim.keymap.set("n", "<leader>yl", function()
	local path = vim.fn.expand("%:p")
	if path == "" then
		vim.notify("Buffer has no file path", vim.log.levels.WARN)
		return
	end
	vim.fn.setreg("+", path .. ":" .. vim.fn.line("."))
end, { desc = "Copy buffer file path with line number to clipboard" })

-- "macros"
-- sort paragraph
vim.keymap.set("n", "<leader>S", "vip:'<,'>sort<CR>", { desc = "Sort paragraph" })
-- Apply . command to each line in visual selection
vim.keymap.set("x", ".", ":normal .<CR>", { desc = "Apply . to each line" })
vim.keymap.set("v", "<leader>j", "y`>pgv:Commentary<CR>", { desc = "Duplicate and comment" })

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
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt_local.wrap = true
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 50 })
	end,
})

-- Bootstrap lazy.nvim
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

-- [[ Configure and install plugins ]]
require("lazy").setup({
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("kanagawa").setup(require("theme"))
			vim.cmd.colorscheme("kanagawa-dragon")
		end,
	},
	"stevearc/oil.nvim",
	"jlanzarotta/bufexplorer",
	"lewis6991/gitsigns.nvim",
	"michaeljsmith/vim-indent-object",
	"ThePrimeagen/harpoon",
	"junegunn/vim-easy-align",
	"tpope/vim-commentary",
	"tpope/vim-sleuth",
	"tpope/vim-surround",
	"gennaro-tedesco/nvim-peekup",
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>tt",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
		},
	},
	"nvim-treesitter/nvim-treesitter",
	"nvim-treesitter/nvim-treesitter-textobjects",
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gg", ":Git <CR>")
			vim.keymap.set("n", "gs", ":Gdiffsplit <CR>")
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
		},
	},
	{
		"ShinKage/idris2-nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
	},
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",
	"onsails/lspkind.nvim",
	-- 'ggandor/lightspeed.nvim'
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
})
