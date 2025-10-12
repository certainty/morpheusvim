return {
	'NeogitOrg/neogit',
	enabled = Morpheus.is_enabled { 'tools', 'git' },
	dependencies = {
		'nvim-lua/plenary.nvim',
		'sindrets/diffview.nvim',
		'lewis6991/gitsigns.nvim'
	},
	opts = {
		integrations = {
			diffview = true,
		},
	},
	keys = {
		{ '<leader>vv',       '<cmd>Neogit<CR>',                                              desc = 'Neogit' },
		{ '<localleader>,vb', function() require('gitsigns').blame_line() end,                desc = 'Blame Line',        buffer = 0 },
		{ '<leader>vtb',      function() require('gitsigns').toggle_current_line_blame() end, desc = 'Toggle Blame Line', buffer = 0 },
	}
}
