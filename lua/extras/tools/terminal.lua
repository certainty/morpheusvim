local utils = require('morpheus.utils')
local M = {}

function M.install(ctx)
	if not utils.is_enabled(ctx, { 'tools', 'terminal' }) then
		return
	end

	-- Add your installation logic here if needed
	utils.plugin_install('akinsho/toggleterm.nvim')
end

function M.configure(ctx)
	if not utils.is_enabled(ctx, { 'tools', 'terminal' }) then
		return
	end
	require('toggleterm').setup { direction = 'float',
		size = function(term)
			if term.direction == 'horizontal' then
				return 15
			elseif term.direction == 'vertical' then
				return vim.o.columns * 0.4
			end
		end,
		persist_size = true, -- Remember terminal size
		close_on_exit = true, -- Close terminal when process exits
	}

	vim.keymap.set('n', '<leader>\\', ':ToggleTerm<CR>', { noremap = true, silent = true })
	vim.keymap.set('n', '<C-\\>', ':ToggleTerm<CR>', { noremap = true, silent = true })
end

return M
