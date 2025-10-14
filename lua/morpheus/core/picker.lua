local ivy = function()
  local height = math.floor(0.3 * vim.o.lines)
  local width = vim.o.columns - 2
  return {
    anchor = 'NW',
    height = height,
    width = width,
    row = math.floor(vim.o.lines - height),
    col = math.floor(vim.o.columns - 2),
  }
end

return {
  {
    'nvim-mini/mini.pick',
    opts = {
      window = { config = ivy },
      options = {
        content_from_bottom = false,
        use_icons = true,
      },
    },
    config = function(_, opts)
      require('mini.pick').setup(opts)
      vim.ui.select = MiniPick.ui_select
    end,
  },
  {
    'nvim-mini/mini.extra',
    config = true,
  },
}
