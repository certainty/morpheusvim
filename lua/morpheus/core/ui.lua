return {
  'nvim-mini/mini.icons',
  priority = 100,
  lazy = false,
  dependencies = {},
  config = function()
    require('mini.icons').setup()
    MiniIcons.mock_nvim_web_devicons()
  end,
}
