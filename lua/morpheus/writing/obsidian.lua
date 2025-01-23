return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  dependencies = {
    'nvim-lua/plenary.nvim',
  },

  config = function(_, opts)
    require('obsidian').setup(opts)
  end,

  init = function()
    vim.keymap.set('n', '<leader>nn', '<cmd>ObsidianQuickSwitch<CR>', { noremap = true, silent = true, desc = 'Quick Switch' })
    vim.keymap.set('n', '<leader>nc', '<cmd>ObsidianNew<CR>', { noremap = true, silent = true, desc = 'New Note' })
    vim.keymap.set('n', '<leader>nC', '<cmd>ObsidianNewFromTemplate<CR>', { noremap = true, silent = true, desc = 'New Note From Template' })
    vim.keymap.set({ 'n', 'v' }, '<leader>nx', '<cmd>ObsidianExtractNote<CR>', { noremap = true, silent = true, desc = 'Extract Note' })

    vim.keymap.set('n', '<leader>nd', '<cmd>ObsidianDailies<CR>', { noremap = true, silent = true, desc = 'Dailies' })
    vim.keymap.set('n', '<leader>nt', '<cmd>ObsidianToday<CR>', { noremap = true, silent = true, desc = 'Today' })
    vim.keymap.set('n', '<leader>nT', '<cmd>ObsidianTomorrow<CR>', { noremap = true, silent = true, desc = 'Today' })
    vim.keymap.set('n', '<leader>ny', '<cmd>ObsidianYesterday<CR>', { noremap = true, silent = true, desc = 'Yesterday' })

    vim.keymap.set('n', '<leader>nm', '<cmd>ObsidianTemplate<CR>', { noremap = true, silent = true, desc = 'Template' })

    vim.keymap.set({ 'n', 'v' }, '<leader>sn', '<cmd>ObsidianSearch<CR>', { noremap = true, silent = true, desc = 'Notes' })
    vim.keymap.set({ 'n', 'v' }, '<leader>ns', '<cmd>ObsidianSearch<CR>', { noremap = true, silent = true, desc = 'Search' })

    vim.keymap.set('n', '<leader>n<', '<cmd>ObsidianBacklinks<CR>', { noremap = true, silent = true, desc = 'Backlinks' })
    vim.keymap.set('n', '<leader>n>', '<cmd>ObsidianLinks<CR>', { noremap = true, silent = true, desc = 'Links' })
  end,

  opts = {
    notes_subdir = 'Inbox',
    new_notes_location = 'notes_subdir',
    templates = {
      folder = 'Templates',
      date_format = '%Y-%m-%d',
      time_format = '%H:%M',
      substitutions = {},
    },
    open_notes_in = 'vsplit',
    daily_notes = {
      folder = 'Journal',
      template = 'Templates/Daily note template.md',
    },
    ui = {
      enable = false,
      checkboxes = {
        ['>'] = { char = '', hl_group = 'ObsidianRightArrow' },
        ['~'] = { char = '󰰱', hl_group = 'ObsidianTilde' },
        ['!'] = { char = '', hl_group = 'ObsidianImportant' },
        [' '] = { char = '☐', hl_group = 'ObsidianTodo' },
        ['x'] = { char = '✔', hl_group = 'ObsidianDone' },
      },
      bullets = { char = '•', hl_group = 'ObsidianBullet' },
    },
    picker = {
      name = 'telescope.nvim',
    },
    sort_by = 'modified',
    sort_reversed = true,
    search_max_lines = 1000,
    completion = {
      -- Set to false to disable completion.
      nvim_cmp = true,
      -- Trigger completion at 2 chars.
      min_chars = 2,
    },
    workspaces = {
      {
        name = 'shared',
        path = '~/SharedNotes',
      },
    },
    preferred_link_style = 'wiki',

    ---@param title string|?
    ---@return string
    note_id_func = function(title)
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- In this case a note with the title 'My new note' will be given an ID that looks
      -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
      local suffix = ''
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. '-' .. suffix
    end,

    -- file it will be ignored but you can customize this behavior here.
    ---@param img string
    follow_img_func = function(img)
      vim.fn.jobstart { 'qlmanage', '-p', img } -- Mac OS quick look preview
    end,

    -- URL it will be ignored but you can customize this behavior here.
    ---@param url string
    follow_url_func = function(url)
      vim.fn.jobstart { 'open', url } -- Mac OS
    end,
  },
}
