return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'ruby',
        'go',
        'gomod',
        'gosum',
        'scala',
        'graphql',
        'json',
        'yaml',
        'typescript',
        'javascript',
        'ruby',
        'css',
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true },
    },
  },
  {
    'stevearc/aerial.nvim',
    opts = {
      filter_kind = { -- Symbols that will appear on the tree
        'Class',
        'Constructor',
        'Enum',
        'Function',
        'Interface',
        'Module',
        'Method',
        'Struct',
      },
      highlight_mode = 'last',
      highlight_on_jump = 1000,
      highlight_on_hover = true,
      highlight_closest = true,
      open_automatic = false,
      autojump = true,
      link_folds_to_tree = false,
      link_tree_to_folds = false,
      attach_mode = 'global',
      backends = { 'treesitter', 'lsp', 'markdown', 'man', 'asciidoc' },
      layout = {
        min_width = 28,
        default_direction = 'left',
        placement = 'edge',
      },
      show_guides = true,
      guides = {
        mid_item = '├ ',
        last_item = '└ ',
        nested_top = '│ ',
        whitespace = '  ',
      },
    },
    config = function(_, opts)
      require('aerial').setup(opts)
      vim.keymap.set('n', '<leader>i', '<cmd>AerialToggle<CR>') -- imenu equivalent
    end,
  },
}
