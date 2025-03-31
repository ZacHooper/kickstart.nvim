return {
  'github/copilot.vim',
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = true,
    keys = {
      { '<leader>ac', '<cmd>CodeCompanionChat Toggle<cr>', mode = 'n', desc = 'Toggle Code Companion Chat' },
    },
  },
}
