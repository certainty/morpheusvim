local utils = require 'morpheus.utils'

local M = {}

M.lsps = {}

--- Sets up LSP keymaps and autocommands for the given buffer.
---@param client vim.lsp.Client
---@param bufnr integer
local function on_attach(client, bufnr)
	---@param lhs string
	---@param rhs string|function
	---@param opts string|vim.keymap.set.Opts
	---@param mode? string|string[]

	local function keymap(lhs, rhs, opts, mode)
		mode = mode or 'n'
		---@cast opts vim.keymap.set.Opts
		opts = type(opts) == 'string' and { desc = opts } or opts
		opts.buffer = bufnr
		vim.keymap.set(mode, lhs, rhs, opts)
	end

	keymap('[d', function()
		vim.diagnostic.jump { count = -1 }
	end, 'Previous diagnostic')
	keymap(']d', function()
		vim.diagnostic.jump { count = 1 }
	end, 'Next diagnostic')
	keymap('[e', function()
		vim.diagnostic.jump { count = -1, severity = vim.diagnostic.severity.ERROR }
	end, 'Previous error')
	keymap(']e', function()
		vim.diagnostic.jump { count = 1, severity = vim.diagnostic.severity.ERROR }
	end, 'Next error')

	vim.lsp.document_color.enable(true, bufnr)
	if client:supports_method 'textDocument/documentColor' then
		keymap('grc', function()
			vim.lsp.document_color.color_presentation()
		end, 'vim.lsp.document_color.color_presentation()', { 'n', 'x' })
	end

	-- format
	if client:supports_method 'textDocument/formatting' then
		keymap('<leader>cf', function()
			vim.lsp.buf.format { bufnr = bufnr, id = client.id }
		end, 'Format Buffer')

		utils.autocmd('LspFormat', 'BufWritePre', '*', function(_)
			vim.lsp.buf.format { bufnr = bufnr, id = client.id }
		end)
	end

	-- picker integration
	if client:supports_method 'textDocument/codeAction' then
		keymap('gra', function()
			require('actions-preview').code_actions()
		end, 'Code Actions', { 'n', 'x' })
	end

	if client:supports_method 'textDocument/references' then
		keymap('grr', function()
			require('mini.extra').pickers.lsp { scope = 'references' }
		end, 'References')
	end

	if client:supports_method 'textDocument/typeDefinition' then
		keymap('grt', function()
			require('mini.extra').pickers.lsp { scope = 'type_definition' }
		end, 'Type definition')
	end

	if client:supports_method 'textDocument/documentSymbol' then
		keymap('<leader>gs', function()
			require('mini.extra').pickers.lsp { scope = 'document_symbol' }
		end, 'Document symbols')
	end

	if client:supports_method 'textDocument/definition' then
		keymap('gd', vim.lsp.buf.definition, 'Definition')

		keymap('gD', function()
			require('mini.extra').pickers.lsp { scope = 'definition' }
		end, 'Definition')

		keymap('gri', function()
			require('mini.extra').pickers.lsp { scope = 'implementation' }
		end, 'implementation')
	end

	if client:supports_method 'textDocument/signatureHelp' then
		keymap('<C-k>', function()
			if require('blink.cmp.completion.windows.menu').win:is_open() then
				require('blink.cmp').hide()
			end
			vim.lsp.buf.signature_help()
		end, 'Signature help', 'i')
	end

	keymap('<localleader>,x', vim.lsp.codelens.run, 'Codelens')
	keymap('grn', vim.lsp.buf.rename, 'Rename')

	if client:supports_method 'textDocument/documentHighlight' then
		utils.autocmd('LspHighlight', { 'CursorHold', 'InsertLeave' }, '*', function(_)
			vim.lsp.buf.document_highlight()
		end)

		utils.autocmd('LspHighlight', { 'CursorMoved', 'InsertEnter', 'BufLeave' }, '*', function(_)
			vim.lsp.buf.clear_references()
		end)
	end
end

local register_capability = vim.lsp.handlers['client/registerCapability']
vim.lsp.handlers['client/registerCapability'] = function(err, res, ctx)
	local client = vim.lsp.get_client_by_id(ctx.client_id)
	if not client then
		return
	end

	on_attach(client, vim.api.nvim_get_current_buf())
	return register_capability(err, res, ctx)
end

utils.autocmd('LspUp', 'LspAttach', '*', function(ctx)
	local client = vim.lsp.get_client_by_id(ctx.evt.data.client_id)
	if not client then
		return
	end
	on_attach(client, ctx.buf)
end)

utils.autocmd('LspDown', 'LspDetach', '*', function(_)
	vim.lsp.buf.clear_references()
	utils.clearAutoCmds 'LspDown'
end)

-- Manage lsps
if Morpheus.is_enabled { 'lang', 'go', 'lsp' } then
	table.insert(M.lsps, 'gopls')
end

if Morpheus.is_enabled { 'lang', 'ruby', 'lsp' } then
	table.insert(M.lsps, 'ruby-lsp')
	table.insert(M.lsps, 'solargraph')
end

if Morpheus.is_enabled { 'lang', 'lua', 'lsp' } then
	table.insert(M.lsps, 'lua_ls')
end

vim.lsp.enable(M.lsps)

return {
	'mason-org/mason.nvim',
	dependencies = {
		{
			'onsails/lspkind.nvim',
			opts = function()
				local symbol_map = {}
				if Morpheus.is_enabled { 'ai', 'copilot' } then
					symbol_map.Copilot = ''
				end
				return {
					enabled = true,
					mode = 'symbol_text',
					preset = 'codicons',
					symbol_map = symbol_map,
					menu = {},
				}
			end,
		},
		{ 'j-hui/fidget.nvim',           opts = { backend = 'minipick' } },
		{ 'aznhe21/actions-preview.nvim' },
		{ 'scalameta/nvim-metals',       enabled = Morpheus.is_enabled { 'lang', 'scala', 'lsp' } },
	},
	opts = {
		ui = {
			icons = {
				package_installed = '✓',
				package_pending = '➜',
				package_uninstalled = '✗',
			},
		},
	},
}
