return {
  'ray-x/go.nvim',
  dependencies = {
    'mfussenegger/nvim-dap',
    'leoluz/nvim-dap-go',
  },
  opts = {
    icons = false,
    lsp_keymaps = false,
    dap_debug_keymap = false,
    diagnostic = vim.g.diagnostic_config,
    iferr_vertical_shift = 2,
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
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'go',
      callback = function()
        vim.keymap.set('n', '<localleader>f', '<cmd>GoFmt<CR>', {
          desc = 'Format Go File',
          buffer = 0,
        })
        vim.keymap.set('n', '<localleader>t', '<cmd>GoTest<CR>', {
          desc = 'Run Go Tests',
          buffer = 0,
        })
        vim.keymap.set('n', '<localleader>g', '<cmd>GoDef<CR>', {
          desc = 'Go Definition',
          buffer = 0,
        })
        vim.keymap.set('n', '<localleader>r', '<cmd>GoRun<CR>', {
          desc = 'Run Go File',
          buffer = 0,
        })
        vim.keymap.set('n', '<localleader>i', '<cmd>GoInfo<CR>', {
          desc = 'Go Info',
          buffer = 0,
        })
        vim.keymap.set('n', '<localleader>c', '<cmd>GoCoverageToggle<CR>', {
          desc = 'Toggle Go Coverage',
          buffer = 0,
        })
        vim.keymap.set('n', '<localleader>t', '<cmd>GoModTidy<CR>', {
          desc = 'Go Mod Tidy',
          buffer = 0,
        })
        vim.keymap.set('n', '<localleader>m', '<cmd>GoIfErr<CR>', {
          desc = 'Insert IfErr',
          buffer = 0,
        })
        vim.keymap.set('n', '<localleader>r', '<cmd>GoRun<CR>', {
          desc = 'Run Go File',
          buffer = 0,
        })
      end,
    })
  end,
  config = function(lp, opts)
    require('go').setup(opts)
  end,
  event = { 'CmdlineEnter' },
  ft = { 'go', 'gomod' },
  build = ':lua require("go.install").update_all_sync()',
}
