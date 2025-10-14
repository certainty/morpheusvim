return {
  'ray-x/go.nvim',
  build = ':lua require("go.install").update_all_sync()',
  ft = { 'go', 'gomod' },
  dependencies = {
    'ray-x/guihua.lua',
  },
  opts = {
    icons = false,
    lsp_keymaps = false,
    dap_debug_keymap = false,
    diagnostic = vim.g.diagnostic_config,
    iferr_vertical_shift = 2,
  },
  keys = {
    { '<localleader>f', '<cmd>GoFmt<cr>', desc = 'Format Go', buffer = true },
    { '<localleader>t', '<cmd>GoTest<cr>', desc = 'Run Go Tests', buffer = true },
    { '<localleader>r', '<cmd>GoRun<cr>', desc = 'Run Go File', buffer = true },
    { '<localleader>i', '<cmd>GoInfo<cr>', desc = 'Go Info', buffer = true },
    { '<localleader>c', '<cmd>GoCoverageToggle<cr>', desc = 'Toggle Go Coverage', buffer = true },
    { '<localleader>t', '<cmd>GoModTidy<cr>', desc = 'Go Mod Tidy', buffer = true },
  },
  init = function()
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
}
