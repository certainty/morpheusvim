return {
  'scalameta/nvim-metals',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'mfussenegger/nvim-dap',
  },
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
    metals_config.capabilities = require('cmp_nvim_lsp').default_capabilities()
    -- metals_config.metalsBinaryPath = '~/.local/bin/metals'

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
    local dap = require 'dap'

    dap.configurations.scala = {
      {
        type = 'scala',
        request = 'launch',
        name = 'RunOrTest',
        metals = {
          runType = 'runOrTestFile',
        },
      },
      {
        type = 'scala',
        request = 'launch',
        name = 'RunOrTest with Args',
        metals = {
          runType = 'runOrTestFile',
          args = function()
            local input = vim.fn.input 'Program arguments: '
            if input == '' then
              return {}
            end
            local args = {}
            for arg in input:gmatch '%S+' do
              table.insert(args, arg)
            end
            return args
          end,
        },
      },
      {
        type = 'scala',
        request = 'launch',
        name = 'Run Specific Main Class',
        metals = {
          runType = 'run',
          mainClass = function()
            return vim.fn.input 'Main class (e.g., com.example.Main): '
          end,
          args = function()
            local input = vim.fn.input 'Program arguments: '
            if input == '' then
              return {}
            end
            local args = {}
            for arg in input:gmatch '%S+' do
              table.insert(args, arg)
            end
            return args
          end,
        },
      },
      {
        type = 'scala',
        request = 'launch',
        name = 'Test Target',
        metals = {
          runType = 'testTarget',
        },
      },
      {
        type = 'scala',
        request = 'launch',
        name = 'Test Specific Class',
        metals = {
          runType = 'testTarget',
          testClass = function()
            return vim.fn.input 'Test class name: '
          end,
        },
      },
      {
        name = 'Debug Attach (5005)',
        type = 'scala',
        request = 'attach',
        hostName = '127.0.0.1',
        port = function()
          return tonumber(vim.fn.input('Port: ', '5005'))
        end,
        metals = {},
      },
    }

    local nvim_metals_group = vim.api.nvim_create_augroup('nvim-metals', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      pattern = self.ft,
      callback = function()
        require('metals').initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })
  end,
}
