-- General
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.undofile = true
vim.o.termguicolors = true
vim.o.hidden = true
vim.o.encoding = 'utf-8'
vim.o.fileencoding = 'utf-8'
vim.o.updatetime = 300
vim.o.timeoutlen = 300
vim.o.scrolloff = 3
vim.o.signcolumn = 'yes'
vim.o.showmode = false

-- mouse
vim.o.mouse = 'a'

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Tabs / indent
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.breakindent = true

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = false
vim.o.incsearch = true

-- Misc
vim.o.wrap = false
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.list = false

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)


-- Windows
vim.o.winborder = 'rounded'
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.inccommand = 'split'
