return {
  {
    'olimorris/codecompanion.nvim',

    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'zbirenbaum/copilot.lua',
    },
    opts = {
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
                  default = 'gemini-2.5-pro',
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
          adapter = 'copilot',
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
          adapter = 'copilot',
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
    },
    keys = {
      -- global
      { '<leader>aa', '<cmd>CodeCompanionChat Toggle<cr>', desc = ' Toggle CodeCompanion', mode = { 'n' } },
      { '<leader>aA', '<cmd>CodeCompanionChat Add<cr>', desc = ' Add To Chat', mode = { 'n', 'v' } },
      { '<leader>aG', '<cmd>CodeCompanionChat gemini_cli<cr>', desc = ' Chat with Gemini-CLI', mode = { 'n', 'v' } },
      { '<leader>ag', '<cmd>CodeCompanionChat copilot_gemini<cr>', desc = ' Chat with Copilot-Gemini', mode = { 'n', 'v' } },
      { '<leader>a1', '<cmd>CodeCompanionChat copilot_claude3<cr>', desc = ' Chat with Claude3', mode = { 'n', 'v' } },
      { '<leader>a2', '<cmd>CodeCompanionChat copilot_claude4<cr>', desc = ' Chat with Claude4', mode = { 'n', 'v' } },
      { '<leader>a3', '<cmd>CodeCompanionChat copilot_gemini<cr>', desc = ' Chat with Gemini', mode = { 'n', 'v' } },
      { '<leader>a4', '<cmd>CodeCompanionChat copilot_gpt5<cr>', desc = ' Chat with GPT5', mode = { 'n', 'v' } },
      { '<leader>a5', '<cmd>CodeCompanionChat copilot<cr>', desc = ' Chat with Copilot (default)', mode = { 'n', 'v' } },
      { '<leader>a6', '<cmd>CodeCompanionChat openai<cr>', desc = ' $ Chat with OpenAI', mode = { 'n', 'v' } },
      { '<leader>a7', '<cmd>CodeCompanionChat gemini<cr>', desc = ' $ Chat with Gemini-Flash', mode = { 'n', 'v' } },
      { '<leader>a8', '<cmd>CodeCompanionChat gemini_cli<cr>', desc = ' $ Chat with Gemini-CLI', mode = { 'n', 'v' } },

      -- at point
      { '<localleader>,a', '<cmd>CodeCompanionActions<cr>', desc = ' CodeCompanionActions', mode = { 'n', 'v' } },
    },
    init = function()
      vim.cmd [[cab cc CodeCompanion]]
    end,
  },
}
