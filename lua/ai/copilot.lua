return {
  {
    'zbirenbaum/copilot-cmp',
    event = 'InsertEnter',
    config = function()
      require('copilot_cmp').setup()

      local cmp = require 'cmp'
      local cfg = cmp.get_config()
      table.insert(cfg.sources, { name = 'copilot', priority = 1000 })

      local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
          return false
        end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match '^%s*$' == nil
      end

      cmp.mapping['<TAB>'] = vim.schedule_wrap(function(fallback)
        if cmp.visible() and has_words_before() then
          cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
        else
          fallback()
        end
      end)
      cmp.setup(cfg)
    end,
  },
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    init = function()
      vim.keymap.set('n', '<leader>ac', '<cmd>Copilot enable<cr>', { desc = 'Enable Copilot' })
      vim.keymap.set('n', '<leader>aC', '<cmd>Copilot disable<cr>', { desc = 'Disable Copilot' })
    end,
    config = function()
      require('copilot').setup {
        suggestion = { enabled = true },
        panel = { enabled = true },
      }
    end,
  },
}
