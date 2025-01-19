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
          require 'diagram.integrations.neorg',
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
    ft = { 'markdown' },
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
      local markdown_group = vim.api.nvim_create_augroup('MarkdownSettings', { clear = true })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'markdown',
        group = markdown_group,
        callback = function(event)
          vim.keymap.set('n', '<localleader>p', '<cmd>MarkdownPreviewToggle<CR>', {
            buffer = event.buf,
            desc = 'Toggle Markdown Preview',
          })
          vim.keymap.set('n', '<localleader>P', '<cmd>MarkdownPreview<CR>', {
            buffer = event.buf,
            desc = 'Markdown Preview',
          })
        end,
      })
    end,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ft = { 'markdown', 'Avante' },
    opts = {},
    config = function()
      require('render-markdown').setup {
        heading = {
          enabled = true,
          width = 'block',
          icons = { '■ ', '■■ ', '■■■ ', '■■■■ ', '■■■■■ ', '■■■■■■ ' },
          -- icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
          backgrounds = {},
          above = '▄',
          -- Used below heading for border
          below = '▀',
        },
        link = {
          enabled = true,
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
