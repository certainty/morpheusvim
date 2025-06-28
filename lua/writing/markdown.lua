return {
  {
    'vhyrro/luarocks.nvim',
    priority = 1001, -- this plugin needs to run before anything else
    opts = {
      rocks = { 'magick' },
    },
  },
  {
    '3rd/image.nvim',
    dependencies = { 'luarocks.nvim' },
    opts = {},
  },
  {
    '3rd/diagram.nvim',
    dependencies = {
      '3rd/image.nvim',
    },
    opts = {},
    config = function()
      require('diagram').setup {
        integrations = {
          require 'diagram.integrations.markdown',
        },
        renderer_options = {
          mermaid = {
            background = '#000000',
            theme = nil,
            scale = 1,
            width = nil,
            height = nil,
          },
        },
      }
    end,
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = 'cd app && yarn install',
    ft = { 'markdown', 'codecompanion' },
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
      local markdown_group = vim.api.nvim_create_augroup('MarkdownSettings', { clear = true })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'markdown',
        group = markdown_group,
        callback = function(event)
          local local_map = require('base.keymap').local_group({ 'n', 'v' }, event.buf, ':')

          local_map('p', '<cmd>MarkdownPreviewToggle<CR>', 'Toggle Markdown Preview')
          local_map('P', '<cmd>MarkdownPreview<CR>', 'Markdown Preview')
        end,
      })
    end,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ft = { 'markdown', 'codecompanion' },
    opts = {},
    config = function()
      local cmp = require 'cmp'
      local cmp_cfg = cmp.get_config()
      table.insert(cmp_cfg.sources, { name = 'render-markdown', priority = 800 })
      cmp.setup(cmp_cfg)

      require('render-markdown').setup {
        render_modes = true,
        indent = {
          enabled = false,
        },
        sign = {
          enabled = false,
        },
        dash = {
          enabled = true,
        },
        code = {
          enabled = true,
        },
        heading = {
          enabled = true,
          icons = { '■ ', '■■ ', '■■■ ', '■■■■ ', '■■■■■ ', '■■■■■■ ' },
          backgrounds = {},
          foregrounds = {
            'RenderMarkdownH1',
            'RenderMarkdownH2',
            'RenderMarkdownH3',
            'RenderMarkdownH4',
            'RenderMarkdownH5',
            'RenderMarkdownH6',
          },
          above = '▄',
          below = '▀',
        },
        link = {
          enabled = true,
        },
        bullet = {
          enabled = true,
          icons = { '•', '•', '•', '•' },
        },
        checkbox = {
          enabled = true,

          -- kept compatible with obsidian minimal theme checkboxes
          custom = {
            cancelled = { raw = '[-]', rendered = '󰜺 ', highlight = 'RenderMarkdownUnchecked' },
            incomplete = { raw = '[/]', rendered = '󰜺 ', highlight = 'RenderMarkdownUnchecked' },
            information = { raw = '[i]', rendered = '󰋼 ', highlight = 'RenderMarkdownBullet' },
            idea = { raw = '[I]', rendered = '󰛨 ' },
            event = { raw = '[e]', rendered = ' ' },
            forwarded = { raw = '[>]', rendered = '󰜴 ' },
            scheduled = { raw = '[<]', rendered = '󰜱 ' },
            important = { raw = '[!]', rendered = ' ' },
            quote = { raw = '["]', rendered = '󰉾 ' },
            star = { raw = '[*]', rendered = ' ' },
            question = { raw = '[?]', rendered = ' ' },
            pros = { raw = '[p]', rendered = '󰔓 ', highlight = 'RenderMarkdownBullet' },
            cons = { raw = '[c]', rendered = '󰔑 ', highlight = 'RenderMarkdownBullet' },
          },
        },
        latex = {
          enabled = true,
          render_modes = false,
          converter = 'latex2text',
          highlight = 'RenderMarkdownMath',
          top_pad = 0,
          bottom_pad = 0,
        },
      }
    end,
  },
}
