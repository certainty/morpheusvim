return {
  {
    'fredrikaverpil/neotest-golang',
    build = function()
      vim.system({ 'go', 'install', 'gotest.tools/gotestsum@latest' }):wait() -- Optional, but recommended
    end,
  },
  {
    'nvim-neotest/neotest',
    dependencies = {
      'fredrikaverpil/neotest-golang',
    },
    filetype = { 'go', 'gomod' },
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      table.insert(
        opts.adapters,
        require 'neotest-golang' {
          runner = 'gotestsum',
        }
      )
    end,
  },
  {
    'leoluz/nvim-dap-go',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    config = function()
      require('dap-go').setup()
    end,
  },
  {
    'ray-x/go.nvim',
    build = ':lua require("go.install").update_all_sync()',
    ft = { 'go', 'gomod' },
    dependencies = {
      'ray-x/guihua.lua',
    },
    commands = { 'GoInfo', 'GoFmt', 'GoRun', 'GoModTidy' },

    opts = {
      icons = false,
      lsp_keymaps = false,
      dap_debug_keymap = false,
      diagnostic = vim.g.diagnostic_config,
      iferr_vertical_shift = 2,
    },

    init = function()
      vim.lsp.enable 'gopls'
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
  },
}
