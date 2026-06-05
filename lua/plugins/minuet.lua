return {
  'milanglacier/minuet-ai.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('minuet').setup {
      -- Enable Copilot-style ghost text
      virtualtext = {
        auto_trigger_ft = { '*' },
        keymap = {
          -- Ctrl-y to accept the whole ghost text suggestion
          accept = '<C-y>',
          accept_line = '<C-a>',
          -- Ctrl-e to dismiss
          dismiss = '<C-e>',
        },
      },
      provider = 'gemini',
      provider_options = {
        gemini = {
          model = 'gemini-3.5-flash',
          api_key = 'GEMINI_API_KEY',
          optional = {
            generationConfig = {
              thinkingConfig = {
                thinkingLevel = 'minimal',
              },
            },
          },
        },
      },
    }
  end,
}
