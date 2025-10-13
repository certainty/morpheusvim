return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  enable = Morpheus.is_enabled { 'writing', 'obsidian' },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },

  init = function()
    -- local notes_map = require('base.keymap').group('n', 'notes')
    -- local at_point = require('base.keymap').at_point({ 'n', 'v' }, 'notes', 0)
    --
    -- -- access obisidian from everywhere
    -- notes_map('n', '<cmd>ObsidianQuickSwitch<CR>', 'Quick Switch')
    -- notes_map('s', '<cmd>ObsidianSearch<CR>', 'Search')
    -- notes_map('c', '<cmd>ObsidianNew<CR>', 'New Note')
    -- notes_map('C', '<cmd>ObsidianNewFromTemplate<CR>', 'New Note From Template')
    -- notes_map('w', '<cmd>ObsidianWorkspace<CR>', 'Switch Workspace')
    -- at_point('x', '<cmd>ObsidianExtractNote<CR>', 'Extract Note')
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
      name = 'mini.pick',
    },
    sort_by = 'modified',
    sort_reversed = true,
    search_max_lines = 1000,
    completion = {
      -- Set to false to disable completion.
      nvim_cmp = false,
      -- Trigger completion at 2 chars.
      min_chars = 2,
    },
    workspaces = {
      {
        name = 'shared',
        path = '~/Documents/Silos/Shared/Notes',
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
      ['<localleader>f'] = {
        action = '<cmd>ObsidianQuickSwitch<cr>',
        opts = { buffer = true, desc = 'Quick switch' },
      },
      ['<localleader>s'] = {
        action = '<cmd>ObsidianSearch<cr>',
        opts = { buffer = true, desc = 'Search' },
      },
      ['<localleader>S'] = {
        action = '<cmd>ObsidianSearchCurrentFile<cr>',
        opts = { buffer = true, desc = 'Search current file' },
      },
      ['<localleader>c'] = {
        action = function()
          return require('obsidian').util.toggle_checkbox()
        end,
        opts = { buffer = true, desc = 'Toggle checkbox' },
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
      ['<localleader>N'] = {
        action = '<cmd>ObsidianNew<cr>',
        opts = { buffer = true, desc = 'New note' },
      },
      ['<localleader>@'] = {
        action = '<cmd>ObsidianTags<cr>',
        opts = { buffer = true, desc = 'Tags' },
      },
      ['<localleader><'] = {
        action = '<cmd>ObsidianBacklinks<cr>',
        opts = { buffer = true, desc = 'Backlinks' },
      },
      ['<localleader>>'] = {
        action = '<cmd>Obsidianlinks<cr>',
        opts = { buffer = true, desc = 'Links' },
      },
      ['<localleader>w'] = {
        action = '<cmd>ObsidianWorkspace<cr>',
        opts = { buffer = true, desc = 'Workspace' },
      },
      ['<localleader>,l'] = {
        action = '<cmd>ObsidianFollowLink<cr>',
        opts = { buffer = true, desc = 'Follow link' },
      },
      ['<localleader>,L'] = {
        action = '<cmd>ObsidianFollowLinkNewTab<cr>',
        opts = { buffer = true, desc = 'Follow link in new tab' },
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
      img_folder = 'assets',

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
