require 'morpheus'

Morpheus.capabilities.enable 'ui'
Morpheus.capabilities.enable('go', { lsp = true, treesitter = true, dap = true })
Morpheus.capabilities.enable('ruby', { lsp = true, treesitter = true, dap = true })
Morpheus.capabilities.enable('scala', { lsp = true, treesitter = true, dap = true })
