return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {
      indent = { char = '┊' }, -- Changed to a dotted line instead of solid
      scope = { enabled = false }, -- Disabled the solid scope line that follows your cursor
    },
  },
}
