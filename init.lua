require 'morpheus'

Morpheus.capabilities.enable 'core'
Morpheus.capabilities.enable('go', { lsp = true, treesitter = true, dap = true })
Morpheus.capabilities.enable('ruby', { lsp = true, treesitter = true, dap = true })
Morpheus.capabilities.enable('scala', { lsp = true, treesitter = true, dap = true })

Morpheus.loader.install_all()
Morpheus.loader.configure_all()
