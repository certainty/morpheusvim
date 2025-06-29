return {

  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('refactoring').setup {}
      require('telescope').load_extension 'refactoring'
    end,
  },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('morpheus-lsp-attach', { clear = true }),
        callback = function(event)
          local g_map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
          end

          local telescope = require 'telescope.builtin'
          local at_point_goto_map = require('base.keymap').at_point('n', 'goto', event.buf)
          local code_map = require('base.keymap').group('n', 'code', event.buf)
          local at_point_code_map = require('base.keymap').at_point('n', 'code', event.buf)
          local at_point_map = require('base.keymap').at_point('n', nil, event.buf)

          g_map('gd', telescope.lsp_definitions, 'Goto Definition')
          at_point_map('<', telescope.lsp_definitions, 'Goto Definition at Point')

          g_map('gr', telescope.lsp_references, 'Goto References')
          at_point_map('>', telescope.lsp_references, 'Goto References at Point')

          g_map('gD', vim.lsp.buf.declaration, 'Goto Declaration')
          at_point_goto_map('D', vim.lsp.buf.declaration, 'Goto Declaration at Point')

          g_map('gI', telescope.lsp_implementations, 'Goto Implementation')
          at_point_goto_map('I', telescope.lsp_implementations, 'Goto Implementation at Point')

          at_point_code_map('k', vim.lsp.buf.hover, 'Hover')
          at_point_code_map('D', telescope.lsp_type_definitions, 'Type Definition')

          code_map('S', telescope.lsp_document_symbols, 'Document Symbols')
          code_map('W', telescope.lsp_dynamic_workspace_symbols, 'Workspace Symbols')

          at_point_code_map('c', vim.lsp.buf.rename, 'Rename')
          at_point_map(',', vim.lsp.buf.code_action, 'Code Action')
          at_point_map('.', vim.lsp.buf.code_action, 'Code Action')

          at_point_map('?', vim.lsp.buf.signature_help, 'Signature Help')
          at_point_code_map('x', vim.lsp.codelens.run, 'Run Code Lens')

          local refactoring = require 'refactoring'
          local refactoring_at_point_map = require('base.keymap').at_point({ 'n', 'x', 'v' }, 'r', event.buf)

          refactoring_at_point_map('r', require('telescope').extensions.refactoring.refactors, 'Refactor')

          refactoring_at_point_map('p', function()
            refactoring.debug.printf { below = false }
          end, 'Add debug print')

          refactoring_at_point_map('v', refactoring.debug.print_var, 'Print var')

          refactoring_at_point_map('c', function()
            refactoring.debug.cleanup {}
          end, 'Cleanup')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('morpheus-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('morpheus-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'morpheus-lsp-highlight', buffer = event2.buf }
              end,
            })
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      local servers = {
        -- clangd = {},
        gopls = {},
        rust_analyzer = {},
        ts_ls = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run
      --    :Mason
      --
      -- You can press `g?` for help in this menu.
      --
      -- `mason` had to be setup earlier: to configure its options see the
      -- `dependencies` table for `nvim-lspconfig` above.
      --
      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {

        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
  {
    'onsails/lspkind.nvim',
    opts = {
      mode = 'symbol_text',
      preset = 'codicons',
      symbol_map = {
        Copilot = '',
      },
      menu = {},
    },
    enabled = vim.g.icons_enabled,
    config = function(_, opts)
      require('lspkind').init(opts)
    end,
  },
}
