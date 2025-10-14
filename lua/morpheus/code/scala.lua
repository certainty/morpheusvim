return {
  'scalameta/nvim-metals',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'mfussenegger/nvim-dap',
  },
  build = ':MetalsInstall',
  ft = { 'scala', 'sbt', 'java' },
  opts = function()
    local metals_config = require('metals').bare_config()

    metals_config.settings = {
      showInferredType = false,
      superMethodLensesEnabled = true,
      showImplicitArguments = true,
      excludedPackages = { 'akka.actor.typed.javadsl', 'com.github.swagger.akka.javadsl' },
      serverVersion = 'latest.snapshot',
    }
    metals_config.init_options.statusBarProvider = 'on'

    metals_config.on_attach = function(client, bufnr)
      require('metals').setup_dap()

      if client.server_capabilities.codeLensProvider then
        vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
          buffer = bufnr,
          callback = vim.lsp.codelens.refresh,
        })
      end
    end

    return metals_config
  end,
  config = function(self, metals_config)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = self.ft,
      callback = function(evt)
        require('metals').initialize_or_attach(metals_config)

        vim.keymap.set('n', '<localleader>mI', '<cmd>MetalsInstall<cr>', { desc = 'Metals Install', buffer = true })
        vim.keymap.set('n', '<localleader>mU', '<cmd>MetalsUpdate<cr>', { desc = 'Metals Update', buffer = true })
        vim.keymap.set('n', '<localleader>mi', '<cmd>MetalsImportBuild<cr>', { desc = 'Metals Import', buffer = true })
        vim.keymap.set('n', '<localleader>ms', '<cmd>MetalsAnalyzeStacktrace<cr>', { desc = 'Analyze Stacktrace', buffer = true })
        vim.keymap.set('n', '<localleader>mc', '<cmd>MetalsCompileAll<cr>', { desc = 'Compile All', buffer = true })
        vim.keymap.set('n', '<localleader>mt', '<cmd>MetalsTestAll<cr>', { desc = 'Test All', buffer = true })
      end,
    })
  end,
}
