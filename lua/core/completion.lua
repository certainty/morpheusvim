local utils = require 'morpheus.utils'

local M = {}

function M.install(ctx)
  utils.plugin_install('Saghen/blink.cmp', vim.version.range '1.*')
  -- TODO: install copilot cmp if enabled
end

function M.configure(ctx)
  vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
  vim.opt.pumheight = 20

  require('blink.cmp').setup {
    cmdline = { enabled = false },

    completion = {
      documentation = { auto_show = true },
      appearance = {
        kind_icons = require('mini.icons').symbol_kinds, -- TODO: does that work?
      },
      menu = {
        draw = {
          components = {
            kind_icon = {
              text = function(ctx)
                if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                  local mini_icon, _ = require('mini.icons').get_icon(ctx.item.data.type, ctx.label)
                  if mini_icon then
                    return mini_icon .. ctx.icon_gap
                  end
                end

                local icon = require('lspkind').symbolic(ctx.kind, { mode = 'symbol' })
                return icon .. ctx.icon_gap
              end,

              -- Optionally, use the highlight groups from mini.icons
              -- You can also add the same function for `kind.highlight` if you want to
              -- keep the highlight groups in sync with the icons.
              highlight = function(ctx)
                if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                  local mini_icon, mini_hl = require('mini.icons').get_icon(ctx.item.data.type, ctx.label)
                  if mini_icon then
                    return mini_hl
                  end
                end
                return ctx.kind_hl
              end,
            },
            kind = {
              -- Optional, use highlights from mini.icons
              highlight = function(ctx)
                if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                  local mini_icon, mini_hl = require('mini.icons').get_icon(ctx.item.data.type, ctx.label)
                  if mini_icon then
                    return mini_hl
                  end
                end
                return ctx.kind_hl
              end,
            },
          },
        },
      },
    },

    -- sources = {
    --   default = { 'copilot', 'lsp', 'path', 'snippets', 'buffer' },
    --   providers = {
    --     copilot = {
    --       name = 'copilot',
    --       module = 'blink-cmp-copilot',
    --       score_offset = 100,
    --       async = true,
    --     },
    --   },
    -- },
  }

  -- extend LSPs
  vim.lsp.config('*', { capabilities = require('blink.cmp').get_lsp_capabilities(nil, true) })
end

return M
