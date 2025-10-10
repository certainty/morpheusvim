vim.opt_local.tabstop = 2
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
vim.treesitter.start()

local metals_config = require('metals').bare_config()
metals_config.settings = {
  showInferredType = false,
  superMethodLensesEnabled = true,
  showImplicitArguments = true,

  excludedPackages = { 'akka.actor.typed.javadsl', 'com.github.swagger.akka.javadsl' },
  serverVersion = 'latest.snapshot',
}
metals_config.init_options.statusBarProvider = 'on'

metals_config.on_attach = function(client, bufnr)
  require('metals').setup_dap()

  if client.server_capabilities.codeLensProvider then
    vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
      buffer = bufnr,
      callback = vim.lsp.codelens.refresh,
    })
  end
end

require('metals').initialize_or_attach(metals_config)
