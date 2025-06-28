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
          copilot = function()
            return require('codecompanion.adapters').extend('copilot', {
              schema = {
                model = {
                  default = vim.g.morpheus.copilot.chat_model,
                },
              },
            })
          end,
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
          gemini = function()
            return require('codecompanion.adapters').extend('gemini', {
              schema = {
                model = {
                  default = 'gemini-2.5-flash',
                },
              },
              env = {
                api_key = 'cmd:op read op://personal/gemini-neovim/credential --no-newline',
              },
            })
          end,

          gemini_pro = function()
            return require('codecompanion.adapters').extend('gemini', {
              schema = {
                model = {
                  default = 'gemini-2.5-pro',
                },
              },
              env = {
                api_key = 'cmd:op read op://personal/gemini-neovim/credential --no-newline',
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
          cmd = {
            adapter = 'anthropic',
            keymaps = {
              close = {
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
      vim.keymap.set({ 'n', 'v' }, '<Localleader>ax', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true, desc = 'CodeCompanionActions' })
      vim.keymap.set({ 'n', 'v' }, '<leader>ax', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true, desc = 'CodeCompanionActions' })
      vim.keymap.set('v', '<Localleader>aA', '<cmd>CodeCompanionChat Add<cr>', { noremap = true, silent = true, desc = ' Add to CodeCompanionChat' })
      vim.keymap.set({ 'n', 'v' }, '<Leader>ax', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true, desc = ' CodeCompanionActions' })
      vim.keymap.set({ 'n', 'v' }, '<Leader>aa', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true, desc = ' Chat toggle' })
      vim.keymap.set({ 'n', 'v' }, '<Leader>a1', '<cmd>CodeCompanionChat anthropic<cr>', { noremap = true, silent = true, desc = ' Chat with Anthropic' })
      vim.keymap.set({ 'n', 'v' }, '<Leader>a2', '<cmd>CodeCompanionChat copilot<cr>', { noremap = true, silent = true, desc = ' Chat with Copilot' })
      vim.keymap.set({ 'n', 'v' }, '<Leader>a3', '<cmd>CodeCompanionChat openai<cr>', { noremap = true, silent = true, desc = ' Chat with OpenAI' })
      vim.keymap.set({ 'n', 'v' }, '<Leader>a4', '<cmd>CodeCompanionChat gemini<cr>', { noremap = true, silent = true, desc = ' Chat with Gemini-Flash' })
      vim.keymap.set({ 'n', 'v' }, '<Leader>a5', '<cmd>CodeCompanionChat gemini-pro<cr>', { noremap = true, silent = true, desc = ' Chat with Gemini-Pro' })

      -- Expand 'cc' into 'CodeCompanion' in the command line
      vim.cmd [[cab cc CodeCompanion]]
    end,
  },
}
