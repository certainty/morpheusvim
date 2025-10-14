return {
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = 'cd app && yarn install',
    ft = { 'markdown', 'codecompanion' },
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'markdown' },
        callback = function(evt)
          vim.keymap.set('n', '<localleader>p', '<cmd>MarkdownPreviewToggle<CR>', { desc = 'Toggle Markdown Preview', buffer = evt.buf })
          vim.keymap.set('n', '<localleader>P', '<cmd>MarkdownPreview<CR>', { desc = 'Markdown Preview', buffer = evt.buf })
        end,
      })
    end,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    ft = { 'markdown', 'codecompanion' },
    opts = {
      completion = { lsp = { enabled = true } },
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
    },
  },
}
