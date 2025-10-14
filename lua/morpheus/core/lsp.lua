--- Sets up LSP keymaps and autocommands for the given buffer.
---@param client vim.lsp.Client
---@param bufnr integer
local function on_attach(client, bufnr)
  ---@param lhs string
  ---@param rhs string|function
  ---@param opts string|vim.keymap.set.Opts
  ---@param mode? string|string[]

  local function keymap(lhs, rhs, opts, mode)
    mode = mode or 'n'
    ---@cast opts vim.keymap.set.Opts
    opts = type(opts) == 'string' and { desc = opts } or opts
    opts.buffer = bufnr
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  if Morpheus.vim_nightly then
    vim.lsp.document_color.enable(true, bufnr)
    if client:supports_method 'textDocument/documentColor' then
      keymap('grc', function()
        vim.lsp.document_color.color_presentation()
      end, 'vim.lsp.document_color.color_presentation()', { 'n', 'x' })
    end
  end

  -- format
  if client:supports_method 'textDocument/formatting' then
    keymap('<leader>cf', function()
      vim.lsp.buf.format { bufnr = bufnr, id = client.id }
    end, 'Format Buffer')

    vim.api.nvim.create_autocmd('BufReadPost', {
      pattern = '*', -- this pattern should match the pattern by which this plugin is loaded with
      callback = function(evt)
        vim.lsp.buf.format { bufnr = evt.bufnr, id = client.id }
      end,
    })
  end

  -- picker integration
  if client:supports_method 'textDocument/codeAction' then
    keymap('gra', function()
      require('actions-preview').code_actions()
    end, 'Code Actions', { 'n', 'x' })

    keymap('<localleader>,.', function()
      require('actions-preview').code_actions()
    end, 'Code Actions', { 'n', 'x' })
  end

  if client:supports_method 'textDocument/references' then
    keymap('grr', function()
      require('mini.extra').pickers.lsp { scope = 'references' }
    end, 'References')
    keymap('<localleader>,r', function()
      require('mini.extra').pickers.lsp { scope = 'references' }
    end, 'References')
  end

  if client:supports_method 'textDocument/typeDefinition' then
    keymap('grt', function()
      require('mini.extra').pickers.lsp { scope = 'type_definition' }
    end, 'Type definition')
  end

  if client:supports_method 'textDocument/documentSymbol' then
    keymap('<leader>gs', function()
      require('mini.extra').pickers.lsp { scope = 'document_symbol' }
    end, 'Document symbols')
  end

  if client:supports_method 'textDocument/definition' then
    keymap('gd', vim.lsp.buf.definition, 'Definition')
    keymap('<localleader>,d', vim.lsp.buf.definition, 'Definition')

    keymap('gD', function()
      require('mini.extra').pickers.lsp { scope = 'definition' }
    end, 'Definition')

    keymap('<localleader>,D', function()
      require('mini.extra').pickers.lsp { scope = 'definition' }
    end, 'Definition')

    keymap('gri', function()
      require('mini.extra').pickers.lsp { scope = 'implementation' }
    end, 'implementation')

    keymap('<localleader>,i', function()
      require('mini.extra').pickers.lsp { scope = 'implementation' }
    end, 'implementation')
  end

  if client:supports_method 'textDocument/signatureHelp' then
    keymap('<C-k>', function()
      if require('blink.cmp.completion.windows.menu').win:is_open() then
        require('blink.cmp').hide()
      end
      vim.lsp.buf.signature_help()
    end, 'Signature help', 'i')
  end

  keymap('<localleader>,x', vim.lsp.codelens.run, 'Codelens')
  keymap('grn', vim.lsp.buf.rename, 'Rename')
end

local register_capability = vim.lsp.handlers['client/registerCapability']
vim.lsp.handlers['client/registerCapability'] = function(err, res, ctx)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  if not client then
    return
  end

  on_attach(client, vim.api.nvim_get_current_buf())
  return register_capability(err, res, ctx)
end

return {
  {
    'onsails/lspkind.nvim',
    opts = {
      symbol_map = {
        Copilot = '',
      },
      enabled = true,
      mode = 'symbol_text',
      preset = 'codicons',
      menu = {},
    },
  },
  { 'aznhe21/actions-preview.nvim', opts = { backend = 'minipick' } },
  {
    'mason-org/mason.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'mason-org/mason-lspconfig.nvim',
      'onsails/lspkind.nvim',
      'aznhe21/actions-preview.nvim',
      -- { 'scalameta/nvim-metals', enabled = Morpheus.is_enabled { 'lang', 'scala', 'lsp' } },
    },
    opts = {
      automatic_enable = true,
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        pattern = '*',
        callback = function(evt)
          local client = vim.lsp.get_client_by_id(evt.data.client_id)
          if not client then
            return
          end
          on_attach(client, evt.bufnr)
        end,
      })
    end,
  },
}
