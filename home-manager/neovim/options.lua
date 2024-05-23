-- THEME
-- vim.opt.termguicolors = true
-- vim.opt.background = "dark"

-- QOL settings
HOME = os.getenv("HOME")
-- vim.opt.backupdir = HOME .. "/.config/nvim/tmp/backup_files/"
-- vim.opt.directory = HOME .. "/.config/nvim/tmp/swap_files/"
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
-- vim.opt.tabstop = 2
-- vim.opt.shiftwidth = 2
-- vim.opt.expandtab = true
-- vim.opt.smartindent = true
-- vim.opt.scrolloff = 10
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.number = true
vim.opt.signcolumn = "yes"
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.wrap = false
vim.opt.formatoptions:remove("o")
vim.opt.shada = { "'10", "<0", "s10", "h" }
vim.opt.timeoutlen = 300
vim.opt.scrolloff = 10
