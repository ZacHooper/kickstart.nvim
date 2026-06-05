---------------------------------------------------------------
-- Highlight when yanking (copying) text. See `:help vim.highlight.on_yank()`
---------------------------------------------------------------
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('zac-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

---------------------------------------------------------------
-- Automatically switch colorscheme based on background mode --
---------------------------------------------------------------
local function set_colorscheme()
  if vim.o.background == 'dark' then
    vim.cmd.colorscheme 'ayu'
  else
    vim.cmd.colorscheme 'rose-pine-dawn'
  end
end

-- Set colorscheme on startup
set_colorscheme()

-- Update colorscheme when background changes
vim.api.nvim_create_autocmd('OptionSet', {
  pattern = 'background',
  callback = set_colorscheme,
})
