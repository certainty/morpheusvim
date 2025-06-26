return {
  'ray-x/go.nvim',
  dependencies = {
    'mfussenegger/nvim-dap',
    'leoluz/nvim-dap-go',
  },
  opts = {
    -- lsp_keymaps = false,
    -- other options
  },
  init = function()
    require('dap-go').setup()
    vim.filetype.add {
      extension = {
        gotmpl = 'gotmpl',
      },
      pattern = {
        ['.*/templates/.*%.tpl'] = 'helm',
        ['.*/templates/.*%.ya?ml'] = 'helm',
        ['helmfile.*%.ya?ml'] = 'helm',
      },
    }
  end,
  config = function(lp, opts)
    require('go').setup(opts)
  end,
  event = { 'CmdlineEnter' },
  ft = { 'go', 'gomod' },
  build = ':lua require("go.install").update_all_sync()',
}
