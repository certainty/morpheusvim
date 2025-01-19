return {
  'CopilotC-Nvim/CopilotChat.nvim',
  dependencies = {
    'zbirenbaum/copilot.lua',
    'stevearc/dressing.nvim',
  },
  build = 'make tiktoken', -- Only on MacOS or Linux
  init = function()
    vim.keymap.set({ 'n', 'v', 'i' }, '<leader>ac', '<cmd>CopilotChat<cr>', { desc = 'Chat' })

    vim.keymap.set('n', '<leader>aa', function()
      local input = vim.fn.input 'Quick Chat: '

      if input ~= '' then
        require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
      end
    end, { desc = 'Quick chat' })

    vim.keymap.set('n', '<leader>ap', function()
      local actions = require 'CopilotChat.actions'
      require('CopilotChat.integrations.telescope').pick(actions.prompt_actions(), { theme = 'ivy' })
    end, { desc = 'Prompts' })
  end,

  opts = {
    model = 'gpt-4o', -- Default model to use, see ':CopilotChatModels' for available models (can be specified manually in prompt via $).
    agent = 'copilot', -- Default agent to use, see ':CopilotChatAgents' for available agents (can be specified manually in prompt via @).
    context = nil, -- Default context or array of contexts to use (can be specified manually in prompt via #).
    temperature = 0.1, -- GPT result temperature

    headless = false, -- Do not write to chat buffer and use history(useful for using callback for custom processing)
    callback = nil, -- Callback to use when ask response is received

    -- default window options
    window = {
      layout = 'vertical', -- 'vertical', 'horizontal', 'float', 'replace'
      width = 0.5, -- fractional width of parent, or absolute width in columns when > 1
      height = 0.5, -- fractional height of parent, or absolute height in rows when > 1
      -- Options below only apply to floating windows
      relative = 'editor', -- 'editor', 'win', 'cursor', 'mouse'
      border = 'rounded', -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
      row = nil, -- row position of the window, default is centered
      col = nil, -- column position of the window, default is centered
      title = 'Copilot Chat', -- title of chat window
      footer = nil, -- footer of chat window
      zindex = 1, -- determines if window is on top or below other floating windows
    },
  },
}
