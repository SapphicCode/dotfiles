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
  { "cohama/lexima.vim",             tag = "v2.1.0" },
  { "nvim-telescope/telescope.nvim", tag = "0.1.4", dependencies = { 'nvim-lua/plenary.nvim' } },
  "lewis6991/gitsigns.nvim",
})

-- gitsigns
require("gitsigns").setup({})
