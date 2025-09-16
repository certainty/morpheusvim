return {
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'zbirenbaum/copilot.lua',
    },
    config = function()
      local default_adapter = nil

      if vim.g.morpheus.ai.default_provider == 'openai' then
        default_adapter = 'copilot_gpt5'
      elseif vim.g.morpheus.ai.default_provider == 'anthropic' then
        default_adapter = 'copilot_claude3'
      elseif vim.g.morpheus.ai.default_provider == 'gemini' then
        default_adapter = 'copilot_gemini'
      else
        default_adapter = 'copilot'
      end

      require('codecompanion').setup {
        extensions = {
          mcphub = {
            callback = 'mcphub.extensions.codecompanion',
            opts = {
              make_vars = true,
              make_slash_commands = true,
              show_result_in_chat = true,
            },
          },
          vectorcode = {
            tool_group = {
              enabled = true,
              extras = {},
              collapse = false,
            },
            tool_opts = {
              ['*'] = {},
              ls = {},
              vectorise = {},
              query = {
                max_num = { chunk = -1, document = -1 },
                default_num = { chunk = 50, document = 10 },
                include_stderr = false,
                use_lsp = false,
                no_duplicate = true,
                chunk_mode = false,
                summarise = {
                  enabled = false,
                  adapter = nil,
                  query_augmented = true,
                },
              },
              files_ls = {},
              files_rm = {},
            },
          },
        },
        adapters = {
          acp = {
            gemini_cli = function()
              return require('codecompanion.adapters').extend('gemini_cli', {
                defaults = {
                  auth_method = 'oauth-personal',
                },
                env = {
                  -- GEMINI_API_KEY = 'cmd:op read op://personal/gemini-neovim/credential --no-newline',
                  GEMINI_MODEL = 'gemini-2.5-pro',
                },
              })
            end,
          },
          http = {
            copilot = function()
              return require('codecompanion.adapters').extend('copilot', {
                schema = {
                  model = {
                    default = vim.g.morpheus.ai.chat_model,
                  },
                },
              })
            end,
            copilot_gemini = function()
              return require('codecompanion.adapters').extend('copilot', {
                schema = {
                  model = {
                    default = 'gemini-2.5-pro',
                  },
                },
              })
            end,
            copilot_gpt5 = function()
              return require('codecompanion.adapters').extend('copilot', {
                schema = {
                  model = {
                    default = 'gpt-5',
                  },
                },
              })
            end,
            copilot_claude3 = function()
              return require('codecompanion.adapters').extend('copilot', {
                schema = {
                  model = {
                    default = 'claude-3.7-sonnet',
                  },
                },
              })
            end,
            copilot_claude4 = function()
              return require('codecompanion.adapters').extend('copilot', {
                schema = {
                  model = {
                    default = 'claude-sonnet-4',
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
        },
        display = {
          chat = {
            show_settings = false, -- if true I can not change adapters in the chat
          },
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
            adapter = default_adapter,
            roles = {
              llm = function(adapter)
                if adapter.name == 'copilot' then
                  return 'Copilot - ' .. adapter.schema.model.default
                else
                  return adapter.formatted_name
                end
              end,
              user = 'Me',
            },
            keymaps = {
              close = {
                -- I almost never want to actually close.
                -- Toggle is what I usually want
                modes = { n = '<C-q>', i = '<C-q>' },
              },
            },
          },
          cmd = {
            adapter = default_adapter,
            keymaps = {
              close = {
                modes = { n = '<C-q>', i = '<C-q>' },
              },
            },
          },
          inline = {
            adapter = default_adapter,
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
      ai_map('G', '<cmd>CodeCompanionChat gemini_cli<cr>', ' Chat with Gemini-CLI')
      ai_map('g', '<cmd>CodeCompanionChat copilot_gemini<cr>', ' Chat with Gemini-CLI')
      ai_map('a', '<cmd>CodeCompanionActions<cr>', ' CodeCompanionActions')
      ai_map('A', '<cmd>CodeCompanionChat Add<cr>', ' Add to CodeCompanionChat')
      ai_map('a', '<cmd>CodeCompanionChat Toggle<cr>', ' Toggle CodeCompanionChat')
      ai_map('1', '<cmd>CodeCompanionChat copilot_claude3<cr>', ' Chat with Claude3')
      ai_map('2', '<cmd>CodeCompanionChat copilot_claude4<cr>', ' Chat with Claude4')
      ai_map('3', '<cmd>CodeCompanionChat copilot_gemini<cr>', ' Chat with Gemini')
      ai_map('4', '<cmd>CodeCompanionChat copilot_gpt5<cr>', ' Chat with GPT5')
      ai_map('5', '<cmd>CodeCompanionChat copilot<cr>', ' Chat with Copilot (default)')
      ai_map('6', '<cmd>CodeCompanionChat openai<cr>', ' $ Chat with OpenAI')
      ai_map('7', '<cmd>CodeCompanionChat gemini<cr>', ' $ Chat with Gemini-Flash')
      ai_map('8', '<cmd>CodeCompanionChat gemini_cli<cr>', ' $ Chat with Gemini-CLI')

      -- Expand 'cc' into 'CodeCompanion' in the command line
      vim.cmd [[cab cc CodeCompanion]]
    end,
  },
}
