return {
  {
    'zbirenbaum/copilot.lua',
    dependencies = { 'neovim/nvim-lspconfig' },
    cmd = 'Copilot',
    build = ':Copilot auth',
    event = 'BufReadPost',
    keys = {
      { '<leader>acc', '<cmd>Copilot enable<cr>', desc = ' Enable' },
    },
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
    init = function()
      vim.lsp.enable 'copilot'
    end,
  },
  {
    'fang2hou/blink-copilot',
    event = 'BufReadPost',
    dependencies = {
      'zbirenbaum/copilot.lua',
    },
  },
  {
    'saghen/blink.cmp',
    optional = true,
    opts = {
      sources = {
        default = { 'copilot', 'lsp', 'buffer', 'path' },
        providers = {
          copilot = {
            name = 'copilot',
            module = 'blink-copilot',
            score_offset = 100,
            async = true,
          },
        },
      },
    },
  },
}
