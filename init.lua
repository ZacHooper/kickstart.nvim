-- [[ Global options ]]
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
-- Python Environment for Plugins
vim.g.python3_host_prog = vim.fn.expand '/Users/zachooper/.config/python-neovim/.venv/bin/python3'

-- [[ Setting options ]]
--  For more options, you can see `:help option-list`
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.number = true -- Make line numbers default
vim.opt.relativenumber = true
vim.opt.mouse = 'a' -- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.showmode = false -- Don't show the mode, since it's already in the status line
-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)
vim.opt.breakindent = true -- Enable break indent
vim.opt.undofile = true -- Save undo history
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes' -- Keep signcolumn on by default
vim.opt.updatetime = 250 -- Decrease update time
vim.opt.timeoutlen = 300 -- Decrease mapped sequence wait time
-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true
-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split' -- Preview substitutions live, as you type!
vim.opt.cursorline = true -- Show which line your cursor is on
vim.opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor.

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>') -- Clear highlights on search when pressing <Esc> in normal mode. See `:help hlsearch`
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' }) -- Diagnostic keymaps
-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
--  Use CTRL+<hjkl> to switch between windows. See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Split screen with cmd-d
vim.keymap.set('n', '<C-d>', ':vsplit<CR>', { desc = 'Split screen vertically' })
vim.keymap.set('n', '<C-S-d>', ':split<CR>', { desc = 'Split screen horizontally' })

-- Quick Filetype setters for pasted snippets
vim.keymap.set('n', '<leader>ls', '<cmd>set filetype=sql<CR>', { desc = 'Set [L]anguage to [S]QL' })
vim.keymap.set('n', '<leader>lj', '<cmd>set filetype=json<CR>', { desc = 'Set [L]anguage to [J]SON' })
vim.keymap.set('n', '<leader>lp', '<cmd>set filetype=python<CR>', { desc = 'Set [L]anguage to [P]ython' })
vim.keymap.set('n', '<leader>lm', '<cmd>set filetype=markdown<CR>', { desc = 'Set [L]anguage to [M]arkdown' })


-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`
-- Highlight when yanking (copying) text. See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('zac-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--  To check the current status of your plugins, run :Lazy
-- Use `opts = {}` to force a plugin to be loaded.
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  { import = 'plugins.coding' },
  { import = 'plugins.editor' },
  { import = 'plugins.git' },
  { import = 'plugins.tools' },
  { import = 'plugins.ui' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- Automatically switch colorscheme based on background mode
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


-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
