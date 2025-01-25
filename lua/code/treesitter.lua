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
      open_automatic = false, -- Open if the buffer is compatible
      autojump = true,
      link_folds_to_tree = false,
      link_tree_to_folds = false,
      attach_mode = 'global',
      backends = { 'lsp', 'treesitter', 'markdown', 'man', 'asciidoc' },
      layout = {
        min_width = 28,
        default_direction = 'right',
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
    end,
  },
}
