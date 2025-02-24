return {
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'zbirenbaum/copilot.lua',
    },
    config = function()
      require('codecompanion').setup {
        display = {
          action_palette = {
            width = 95,
            height = 10,
            prompt = 'Prompt ',
            provider = 'telescope',
            opts = {
              show_default_actions = true,
              show_default_prompt_library = true,
            },
          },
        },
        strategies = {
          chat = {
            adapter = 'copilot',
          },
          inline = {
            adapter = 'copilot',
            keymaps = {
              accept_change = {
                modes = { n = 'ga' },
                description = 'Accept the suggested change',
              },
              reject_change = {
                modes = { n = 'gr' },
                description = 'Reject the suggested change',
              },
            },
          },
        },
      }
    end,
    init = function()
      vim.keymap.set({ 'n', 'v' }, '<Localleader>aa', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })
      vim.keymap.set('v', '<Localleader>aA', '<cmd>CodeCompanionChat Add<cr>', { noremap = true, silent = true })
      vim.keymap.set({ 'n', 'v' }, '<Leader>a,', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })
      vim.keymap.set({ 'n', 'v' }, '<Leader>aa', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true })

      -- Expand 'cc' into 'CodeCompanion' in the command line
      vim.cmd [[cab cc CodeCompanion]]
    end,
  },
}
