vim.g.mapleader = ' '
vim.g.maplocalleader = ','
vim.g.have_nerd_font = true

-- morpheus specific settings
vim.g.morpheus = {
  copilot = {
    -- completion_model = 'gemini-2.0-flash-001',
    completion_model = 'gpt-4.1',
    chat_model = 'claude-3.7-sonnet',
  },
}

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = false -- this is annoying
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.inccommand = 'split'
vim.opt.cursorline = false
vim.opt.scrolloff = 10

if vim.g.have_nerd_font then
  local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
  local diagnostic_signs = {}
  for type, icon in pairs(signs) do
    diagnostic_signs[vim.diagnostic.severity[type]] = icon
  end
  vim.g.diagnostic_config = {
    signs = { text = diagnostic_signs },
    virtual_text = false,
    underline = true,
    update_in_insert = false,
    float = {
      border = 'rounded',
    },
  }
else
  vim.g.diagnostic_config = {
    signs = true,
    virtual_text = false,
    underline = true,
    update_in_insert = false,
    float = {
      border = 'rounded',
    },
  }
  vim.diagnostic.config {
    signs = true,
    virtual_text = false,
  }
end
vim.diagnostic.config(vim.g.diagnostic_config)
