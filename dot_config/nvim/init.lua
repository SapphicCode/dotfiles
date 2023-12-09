-- fix indents
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.expandtab = true
-- make indents smarter
vim.o.smartindent = true
-- smart wrapping
vim.o.linebreak = true
vim.o.breakindent = true
vim.o.breakindentopt = "shift:4"
-- line numbers
vim.o.number = true
vim.o.numberwidth = 6

-- plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"theacodes/witchhazel", -- color scheme

	{ "cohama/lexima.vim", tag = "v2.1.0" }, -- auto-insert matched characters
	"tpope/vim-sleuth", -- heuristic indentation detection

	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},

	"neovim/nvim-lspconfig",
	"creativenull/efmls-configs-nvim",
	{ "lukas-reineke/lsp-format.nvim", opts = {} }, -- auto-formatting

	{ "lewis6991/gitsigns.nvim", opts = {} }, -- git line changes in line number gutter
	{
		"f-person/git-blame.nvim",
		opts = {
			virtual_text_column = 100,
			date_format = "%Y-%m-%d %H:%M",
		},
	}, -- blame on cursor line
})

-- witch hazel
vim.o.termguicolors = true
vim.cmd("colorscheme witchhazel-hypercolor")

-- keybinds
telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope.find_files)
vim.keymap.set("n", "<leader>fg", telescope.live_grep)
vim.keymap.set("n", "<leader>fb", telescope.buffers)

-- language server config
if vim.fn.executable("efm-langserver") then
	require("lspconfig").efm.setup({
		init_options = { documentFormatting = true },
		on_attach = require("lsp-format").on_attach,
		settings = {
			rootMarkers = { ".git/" },
			languages = {
				lua = {
					require("efmls-configs.formatters.stylua"),
				},
				python = {
					require("efmls-configs.formatters.isort"),
					require("efmls-configs.formatters.black"),
				},
				nix = {
					{
						formatCommand = "nixpkgs-fmt",
						formatStdin = true,
						rootMarkers = {
							"flake.nix",
							"shell.nix",
							"default.nix",
						},
					}
				}
			},
		},
	})
end
