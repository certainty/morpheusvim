return {
  {
    'Saghen/blink.cmp',
    version = '1.*',
    dependencies = {
      { 'nvim-mini/mini.nvim' },
      { 'onsails/lspkind.nvim' },
      {
        'giuxtaposition/blink-cmp-copilot',
        enabled = Morpheus.is_enabled { 'ai', 'copilot' },
      },
    },
    opts = function()
      local sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      }

      if Morpheus.is_enabled { 'ai', 'copilot' } then
        sources.default = { 'copilot', 'lsp', 'path', 'snippets', 'buffer' }
        sources.providers = {
          copilot = {
            name = 'copilot',
            module = 'blink-cmp-copilot',
            score_offset = 100,
            async = true,
          },
        }
      end

      return {
        sources = sources,
        cmdline = { enabled = false },
        appearance = {
          kind_icons = require('mini.icons').symbol_kinds,
        },
        completion = {
          documentation = { auto_show = true },
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
      }
    end,
    init = function()
      vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
      vim.opt.pumheight = 20

      vim.lsp.config('*', { capabilities = require('blink.cmp').get_lsp_capabilities(nil, true) })
    end,
  },
}
