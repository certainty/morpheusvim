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
      local ai_map = require('base.keymap').group({ 'n', 'v' }, 'ai')
      local ai_at_point = require('base.keymap').at_point({ 'n', 'v' }, 'ai')

      ai_at_point('a', '<cmd>CodeCompanionActions<cr>', ' CodeCompanionActions')
      ai_map('a', '<cmd>CodeCompanionActions<cr>', ' CodeCompanionActions')
      ai_map('A', '<cmd>CodeCompanionChat Add<cr>', ' Add to CodeCompanionChat')
      ai_map('a', '<cmd>CodeCompanionChat Toggle<cr>', ' Toggle CodeCompanionChat')
      ai_map('1', '<cmd>CodeCompanionChat anthropic<cr>', ' Chat with Anthropic')
      ai_map('2', '<cmd>CodeCompanionChat copilot<cr>', ' Chat with Copilot')
      ai_map('3', '<cmd>CodeCompanionChat openai<cr>', ' Chat with OpenAI')
      ai_map('4', '<cmd>CodeCompanionChat gemini<cr>', ' Chat with Gemini-Flash')
      ai_map('5', '<cmd>CodeCompanionChat gemini-pro<cr>', ' Chat with Gemini-Pro')

      -- Expand 'cc' into 'CodeCompanion' in the command line
      vim.cmd [[cab cc CodeCompanion]]
    end,
  },
}
