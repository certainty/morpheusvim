vim.pack.add({ 'https://github.com/ray-x/go.nvim.git' })
vim.pack.add({ 'https://github.com/leoluz/nvim-dap-go.git' })

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


require('go').setup {
  goimport = 'gopls',   -- if set to 'gopls' will use gopls format
  fillstruct = 'gopls', -- can be nil (use fillstruct, slower) and gopls
  gofmt = 'gofumpt',    -- if set to gopls will use gopls format
  icons = false,
  tag_transform = false,
  test_template = '',
  test_template_dir = '',
  comment_placeholder = '   ',
  lsp_cfg = false,      -- true: use non-default gopls setup specified in go/lsp.lua
  lsp_on_attach = nil,  -- nil: use on_attach function defined in go/lsp.lua
  lsp_codelens = true,  -- set to false to disable codelens, true to enable
  lsp_diag_hdlr = true, -- hook lsp diag handler
  lsp_inlay_hints = {
    enable = true,
  },
  luasnip = false,
  dap_debug = true,
  dap_debug_keymap = false,
  dap_debug_gui = true,
  dap_debug_vt = false, -- true: show variable floating window
}

require('dap-go').setup()
