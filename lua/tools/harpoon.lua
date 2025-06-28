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
    local goto_map = require('base.keymap').group('n', 'goto')
    local local_goto_map = require('base.keymap').group('n', 'goto')

    goto_map('a', function()
      harpoon:list():add()
    end, 'Add file to harpoon list')
    local_goto_map('a', function()
      harpoon:list():add()
    end, 'Add file to harpoon list')

    goto_map('g', function()
      toggle_telescope(harpoon:list())
    end, 'Open harpoon window')

    vim.keymap.set('n', '<C-M-P>', function()
      harpoon:list():prev()
    end, { desc = 'Select previous in harpoon list' })

    vim.keymap.set('n', '[h', function()
      harpoon:list():prev()
    end, { desc = 'Harpoon prev' })

    vim.keymap.set('n', '<C-M-N>', function()
      harpoon:list():next()
    end, { desc = 'Select next in harpoon list' })

    vim.keymap.set('n', ']h', function()
      harpoon:list():next()
    end, { desc = 'Harpoon next' })
  end,
}
