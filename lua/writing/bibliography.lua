return {
  {
    'liamvdvyver/cmp-bibtex',
    opts = { filetypes = { 'markdown', 'rmd', 'tex' } },
    config = function()
      require('cmp_bibtex').setup {}
      local cmp = require 'cmp'
      local cmp_cfg = cmp.get_config()
      table.insert(cmp_cfg.sources, { name = 'bibtex' })
      cmp.setup(cmp_cfg)
    end,
  },
}
