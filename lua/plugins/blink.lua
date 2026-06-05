return {
  { -- Autocompletion
    'saghen/blink.cmp',
    version = '*',
    dependencies = {
      { 'L3MON4D3/LuaSnip', version = '2.*' },
      { 'rafamadriz/friendly-snippets' },
    },
    opts = {
      cmdline = {
        enabled = false, -- Disables blink.cmp on the command line (fixes the :w error)
      },
      keymap = {
        preset = 'default',
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
      },
      completion = { 
        trigger = { prefetch_on_insert = false } 
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'minuet' },
        providers = {
          minuet = {
            name = 'minuet',
            module = 'minuet.blink',
            score_offset = 100,
            async = true,
            timeout_ms = 3000,
          },
        },
        per_filetype = {
          codecompanion = { 'codecompanion' },
        },
      },
      snippets = { preset = 'luasnip' },
    },
  },
}
