vim.lsp.enable({
  'lua_ls',
  'gopls',
  'ruby-lsp',
  'solargraph'
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local buffer = ev.buf

    if client then
      if client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
        vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
        -- vim.lsp.completion.enable(true, client.id, buffer, { autotrigger = true })
      end

      -- Auto-format on save
      if client:supports_method('textDocument/formatting') then
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = buffer,
          callback = function()
            vim.lsp.buf.format({ bufnr = buffer, id = client.id })
          end,
        })
      end
    end

    vim.keymap.set('n', '<localleader>gs',
      function() require('mini.extra').pickers.lsp({ scope = "document_symbol" }) end,
      { desc = "Document Symbols", buffer = buffer })


    vim.keymap.set('n', '<localleader>gS',
      function() require('mini.extra').pickers.lsp({ scope = "workspace_symbol" }) end,
      { desc = "Workspace Symbols", buffer = buffer })

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Definition", buffer = buffer })

    vim.keymap.set('n', 'gD',
      function() require('mini.extra').pickers.lsp({ scope = "definition" }) end,
      { desc = "Definition", buffer = buffer })

    vim.keymap.set('n', 'grr',
      function() require('mini.extra').pickers.lsp({ scope = "references" }) end,
      { desc = "References", buffer = buffer })

    vim.keymap.set('n', 'grt',
      function() require('mini.extra').pickers.lsp({ scope = "type_definition" }) end,
      { desc = "Type Definition", buffer = buffer })

    vim.keymap.set('n', 'gri',
      function() require('mini.extra').pickers.lsp({ scope = "implementation" }) end,
      { desc = "Implementation", buffer = buffer })

    vim.keymap.set('n', '<localleader>,,', vim.lsp.buf.code_action, { desc = "Code Action", buffer = buffer })
    vim.keymap.set('n', '<localleader>,x', vim.lsp.codelens.run, { desc = "Code Lens", buffer = buffer })
  end
})
