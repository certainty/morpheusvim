return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/neotest-vim-test',
      'vim-test/vim-test',
      'nvim-neotest/nvim-nio',
    },
    filetype = { 'scala' },
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      table.insert(
        opts.adapters,
        require 'neotest-vim-test' {
          allow_file_types = { 'scala', 'sbt', 'java' },
          runnsers = { scala = 'sbt' },
        }
      )
    end,
  },
  {
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
    end,
  },
}
