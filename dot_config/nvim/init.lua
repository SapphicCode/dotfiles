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

-- language-specific 2-space tabs
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "json", "yaml", "toml", "lua" },
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.expandtab = true
	end,
})

-- language-specific tabs (ew)
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "go" },
	callback = function()
		vim.opt_local.expandtab = false
	end,
})

-- shift+arrow selections
vim.opt.keymodel = { "startsel", "stopsel" }

-- Ctrl+C / Ctrl+X in visual mode
vim.keymap.set("v", "<C-c>", '"+y', { noremap = true })
vim.keymap.set("v", "<C-x>", '"+d', { noremap = true })

-- Ctrl+V in insert/normal mode
-- Normal mode: proper paste with auto-format
vim.keymap.set("n", "<C-v>", function()
	vim.cmd('normal! "+p')
	vim.lsp.buf.format({ async = false })
end, { noremap = true })
-- Insert mode: exit to normal, paste, format, return to insert
vim.keymap.set("i", "<C-v>", function()
	vim.cmd('stopinsert')
	vim.cmd('normal! "+p')
	vim.lsp.buf.format({ async = false })
	vim.cmd('startinsert')
end, { noremap = true })

-- Backspace in visual mode (delete without copying)
vim.keymap.set("v", "<BS>", '"_d', { noremap = true })

-- remember last cursor position, https://github.com/creativenull/dotfiles/blob/9ae60de4f926436d5682406a5b801a3768bbc765/config/nvim/init.lua#L70-L86
local remember_cursor_position = vim.api.nvim_create_augroup("RememberCursorPosition", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
	group = remember_cursor_position,
	callback = function(args)
		local valid_line = vim.fn.line([['"]]) >= 1 and vim.fn.line([['"]]) < vim.fn.line("$")
		local not_commit = vim.b[args.buf].filetype ~= "commit"

		if valid_line and not_commit then
			vim.cmd([[normal! g`"]])
		end
	end,
})

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
	{
		"saghen/blink.cmp",
		version = "1.*",
		opts = {
			keymap = {
				preset = "default",
				["<CR>"] = { "accept", "fallback" },
			},
			signature = { enabled = true },
		},
	},

	-- syntax highlighting
	{ "nvim-treesitter/nvim-treesitter", lazy = false, build = ":TSUpdate" },
	{ "LhKipp/nvim-nu", config = false },

	{ "lewis6991/gitsigns.nvim", opts = {} }, -- git line changes in line number gutter
	{
		"f-person/git-blame.nvim",
		opts = {
			virtual_text_column = 100,
			date_format = "%Y-%m-%d %H:%M",
		},
	}, -- blame on cursor line

	"dstein64/vim-startuptime",

	-- tree sidebar
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		lazy = false, -- neo-tree will lazily load itself
	},
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
if vim.env.NVIM_NO_LSP == nil then
	if vim.fn.executable("efm-langserver") == 1 then
		vim.lsp.config("efm", {
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
							formatCommand = "alejandra",
							formatStdin = true,
							rootMarkers = {
								"flake.nix",
								"shell.nix",
								"default.nix",
							},
						},
					},
				},
			},
		})
	end
	if vim.fn.executable("nu") == 1 then
		vim.lsp.enable("nushell")
	end
	if vim.fn.executable("gcc") == 1 then
		require("nvim-treesitter.config").setup({
			highlight = { enable = true },
			ensure_installed = { "lua", "vim", "vimdoc", "python", "nu" },
		})
	end
	if vim.fn.executable("pyright") == 1 then
		vim.lsp.enable("pyright")
	end
	if vim.fn.executable("gopls") == 1 then
		vim.lsp.enable("gopls")
	end
end
