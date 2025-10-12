return {
	{
		'zbirenbaum/copilot.lua',
		enabled = Morpheus.is_enabled { 'ai', 'copilot' },
		keys = {
			{ '<leader>acc', '<cmd>Copilot enable<cr>', desc = 'Enable Copilot' },
		},
		event = "InsertEnter",
		opts = {
			suggestion = { enabled = false },
			panel = { enabled = false },
		},
	},
}
