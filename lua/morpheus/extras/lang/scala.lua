local utils = require 'morpheus.utils'

return {
  'scalameta/nvim-metals',
  dependencies = { 'nvim-lua/plenary.nvim' },
  enable = Morpheus.is_enabled { 'lang', 'scala', 'lsp' },
  ft = { 'scala', 'sbt', 'java' },
  event = { 'CmdlineEnter' },
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

    if Morpheus.is_enabled { 'lang', 'scala', 'dap' } then
      metals_config.on_attach = function(client, bufnr)
        require('metals').setup_dap()

        if client.server_capabilities.codeLensProvider then
          vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
            buffer = bufnr,
            callback = vim.lsp.codelens.refresh,
          })
        end
      end
    end

    return metals_config
  end,
  config = function(self, metals_config)
    utils.ftcmd('ScalaMetals', self.ft, function(ctx)
      require('metals').initialize_or_attach(metals_config)
      ctx.map('n', '<localleader>mI', '<cmd>MetalsInstall<cr>', { desc = 'Metals Install' })
      ctx.map('n', '<localleader>mU', '<cmd>MetalsUpdate<cr>', { desc = 'Metals Update' })
      ctx.map('n', '<localleader>mi', '<cmd>MetalsImportBuild<cr>', { desc = 'Metals Import' })
      ctx.map('n', '<localleader>ms', '<cmd>MetalsAnalyzeStacktrace<cr>', { desc = 'Analyze Stacktrace' })
      ctx.map('n', '<localleader>mc', '<cmd>MetalsCompileAll<cr>', { desc = 'Compile All' })
      ctx.map('n', '<localleader>mt', '<cmd>MetalsTestAll<cr>', { desc = 'Test All' })
    end)
  end,
}
