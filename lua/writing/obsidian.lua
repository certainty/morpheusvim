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
    notes_subdir = '00 Inbox',
    new_notes_location = 'notes_subdir',
    templates = {
      folder = 'Templates',
      date_format = '%Y-%m-%d',
      time_format = '%H:%M',
      substitutions = {
        quarter = function()
          local month = os.date('*t').month
          local quarter = math.ceil(month / 3)
          return 'Q' .. quarter
        end,
        year = function()
          return os.date '%Y'
        end,
      },
    },
    open_notes_in = 'vsplit',

    daily_notes = {
      folder = os.date 'Journal/%Y',
      default_tags = { 'daily' },
      template = 'Daily.md',
    },
    ui = {
      enable = false,
      checkboxes = {
        ['>'] = { char = '󰜱', hl_group = 'ObsidianRightArrow' },
        ['<'] = { char = '󰜴', hl_group = 'ObsidianRightArrow' },
        ['~'] = { char = '󰰱', hl_group = 'ObsidianTilde' },
        ['!'] = { char = '', hl_group = 'ObsidianImportant' },
        ['?'] = { char = '', hl_group = 'ObsidianBullet' },
        [' '] = { char = '◯', hl_group = 'ObsidianTodo' },
        ['-'] = { char = '󰜺', hl_group = 'ObsidianDone' },
        ['x'] = { char = '✔', hl_group = 'ObsidianDone' },
        ['e'] = { char = '', hl_group = 'ObsidianTodo' },
        ['*'] = { char = '', hl_group = 'ObsidianBullet' },
        ['q'] = { char = '󰉾', hl_group = 'ObsodianBullet' },
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
    mappings = {
      ['gf'] = {
        action = function()
          return require('obsidian').util.gf_passthrough()
        end,
        opts = { expr = true, buffer = true, desc = 'Follow', noremap = false },
      },
      ['<localleader>c'] = {
        action = function()
          return require('obsidian').util.toggle_checkbox()
        end,
        opts = { buffer = true, desc = 'Toggle checkbox' },
      },
      ['<localleader>l'] = {
        action = '<cmd>ObsidianFollowLink<cr>',
        opts = { buffer = true, desc = 'Follow link' },
      },
      ['<localleader>t'] = {
        action = '<cmd>ObsidianTemplate<cr>',
        opts = { buffer = true, desc = 'Template' },
      },
      ['<localleader>r'] = {
        action = '<cmd>ObsidianRename<cr>',
        opts = { buffer = true, desc = 'Rename' },
      },
      ['<localleader>o'] = {
        action = '<cmd>ObsidianTOC<cr>',
        opts = { buffer = true, desc = 'TOC' },
      },
      ['<localleader>y'] = {
        action = '<cmd>ObsidianPasteImg<cr>',
        opts = { buffer = true, desc = 'Paste image' },
      },
      ['<localleader>,'] = {
        action = '<cmd>ObsidianTags<cr>',
        opts = { buffer = true, desc = 'Tags' },
      },
      ['<localleader><'] = {
        action = '<cmd>ObsidianBacklinks<cr>',
        opts = { buffer = true, desc = 'Backlinks' },
      },
    },

    ---@param title string|?
    ---@return string
    note_id_func = function(title)
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

    attachments = {
      img_folder = 'Assets',

      ---@return string
      img_name_func = function()
        -- Prefix image names with timestamp.
        return string.format('%s-', os.time())
      end,

      ---@param client obsidian.Client
      ---@param path obsidian.Path the absolute path to the image file
      ---@return string
      img_text_func = function(client, path)
        return string.format('![%s](%s)', path.name, path)
      end,
    },
  },
}
