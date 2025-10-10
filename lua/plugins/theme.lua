vim.pack.add({ 'https://github.com/catppuccin/nvim.git' })

require('catppuccin').setup({
  flavour = 'auto',
  background = {
    light = 'latte',
    dark = 'mocha',
  },
  color_overrides = {
    mocha = {
      base = '#000000',
      mantle = '#000000',
      crust = '#000000',
    },
    latte = {
      base = '#eeeeee',
    },
  },
  default_integrations = true,
  integrations = {
    cmp = true,
    mason = true,
    aerial = true,
    neogit = true,
    neotest = true,
    dap = true,
    dap_ui = true,
    diffview = true,
    gitsigns = true,
    neotree = true,
    telescope = true,
    which_key = true,
    treesitter = true,
    mini = {
      enabled = true,
      indentscope_color = 'lavendar',
    },
  }
})

vim.cmd [[colorscheme catppuccin]]
vim.cmd [[hi Comment gui=none]]
