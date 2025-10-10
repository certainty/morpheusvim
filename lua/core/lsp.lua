vim.lsp.enable({
  'lua_ls',
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
  end
})
