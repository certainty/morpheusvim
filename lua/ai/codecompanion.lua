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
        adapters = {
          openai = function()
            return require('codecompanion.adapters').extend('openai', {
              env = {
                api_key = 'cmd:op read op://personal/openai-neovim/credential --no-newline',
              },
            })
          end,
          anthropic = function()
            return require('codecompanion.adapters').extend('anthropic', {
              env = {
                api_key = 'cmd:op read op://personal/anthropic-neovim/credential --no-newline',
              },
            })
          end,
        },
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
            keymaps = {
              close = {
                -- I almost never want to actually close.
                -- Toggle is what I usually want
                modes = { n = '<C-q>', i = '<C-q>' },
              },
            },
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
