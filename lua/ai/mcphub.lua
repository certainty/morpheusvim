return {
  'ravitemer/mcphub.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  build = 'npm install -g mcp-hub@latest', -- Installs `mcp-hub` node binary globally
  config = function()
    require('mcphub').setup {
      global_env = function(context)
        local env = {}

        env.REDIS_URL = os.getenv 'REDIS_URL'

        -- Add context-aware variables
        if context.is_workspace_mode then
          env.WORKSPACE_ROOT = context.workspace_root
          env.WORKSPACE_PORT = tostring(context.port)
        end
        env.CONFIG_FILES = table.concat(context.config_files, ':')
        return env
      end,
    }
  end,
}
