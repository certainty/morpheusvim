return {
  {
    'folke/snacks.nvim',
    enable = Morpheus.is_enabled { ui, dashboard },
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        sections = {
          { section = 'header' },
          { icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
          { icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
          { section = 'startup' },
        },
      },

      indent = { enabled = false },
      input = { enabled = true },
      gitbrowser = { enabled = true },
      animation = { knabled = false },
    },
    keys = {
      {
        '<leader>vo',
        function()
          Snacks.gitbrowse()
        end,
        desc = 'Browse',
      },
    },
  },
}
