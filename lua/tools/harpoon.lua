return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  init = function()
    local harpoon = require 'harpoon'
    local conf = require('telescope.config').values

    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end
    vim.keymap.set('n', '<leader>ga', function()
      harpoon:list():add()
    end, { desc = 'Add file to harpoon list' })
    vim.keymap.set('n', '<leader>gg', function()
      toggle_telescope(harpoon:list())
    end, { desc = 'Open harpoon window' })
    vim.keymap.set('n', '<C-M-P>', function()
      harpoon:list():prev()
    end, { desc = 'Select previous in harpoon list' })
    vim.keymap.set('n', '<C-M-N>', function()
      harpoon:list():next()
    end, { desc = 'Select next in harpoon list' })
  end,
}
