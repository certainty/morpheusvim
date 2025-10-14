return {
  'akinsho/toggleterm.nvim',
  config = function()
    require('toggleterm').setup {
      direction = 'float',
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

    function _G.set_terminal_keymaps()
      local opts = { noremap = true, silent = true }
      -- Navigate back to the normal buffer
      vim.api.nvim_buf_set_keymap(0, 't', '<Esc>', [[<C-\><C-n>]], opts)
      -- Navigate to the terminal
      vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-w>h]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-w>j]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-w>k]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-w>l]], opts)
    end

    vim.cmd 'autocmd! TermOpen term://* lua set_terminal_keymaps()'

    vim.keymap.set('n', '<leader>\\', ':ToggleTerm<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<C-\\>', ':ToggleTerm<CR>', { noremap = true, silent = true })
  end,
}
