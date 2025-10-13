return {
  {
    'zbirenbaum/copilot.lua',
    lazy = false,
    enabled = Morpheus.is_enabled { 'ai', 'copilot' },
    keys = {
      { '<leader>acc', '<cmd>Copilot enable<cr>', desc = 'Enable Copilot' },
    },
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },
}
