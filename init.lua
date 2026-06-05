     1|-- [[ Global options ]]
     2|--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
     3|vim.g.mapleader = ' '
     4|vim.g.maplocalleader = ' '
     5|vim.g.have_nerd_font = true
     6|-- Python Environment for Plugins
     7|vim.g.python3_host_prog = vim.fn.expand '/Users/zachooper/.config/python-neovim/.venv/bin/python3'
     8|
     9|-- [[ Setting options ]]
    10|--  For more options, you can see `:help option-list`
    11|vim.opt.shiftwidth = 4
    12|vim.opt.tabstop = 4
    13|vim.opt.termguicolors = true
    14|vim.opt.number = true -- Make line numbers default
    15|vim.opt.relativenumber = true
    16|vim.opt.mouse = 'a' -- Enable mouse mode, can be useful for resizing splits for example!
    17|vim.opt.showmode = false -- Don't show the mode, since it's already in the status line
    18|-- Sync clipboard between OS and Neovim.
    19|--  Remove this option if you want your OS clipboard to remain independent.
    20|--  See `:help 'clipboard'`
    21|vim.schedule(function()
    22|  vim.opt.clipboard = 'unnamedplus'
    23|end)
    24|vim.opt.breakindent = true -- Enable break indent
    25|vim.opt.undofile = true -- Save undo history
    26|-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
    27|vim.opt.ignorecase = true
    28|vim.opt.smartcase = true
    29|vim.opt.signcolumn = 'yes' -- Keep signcolumn on by default
    30|vim.opt.updatetime = 250 -- Decrease update time
    31|vim.opt.timeoutlen = 300 -- Decrease mapped sequence wait time
    32|-- Configure how new splits should be opened
    33|vim.opt.splitright = true
    34|vim.opt.splitbelow = true
    35|-- Sets how neovim will display certain whitespace characters in the editor.
    36|--  See `:help 'list'`
    37|--  and `:help 'listchars'`
    38|vim.opt.list = true
    39|vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
    40|vim.opt.inccommand = 'split' -- Preview substitutions live, as you type!
    41|vim.opt.cursorline = true -- Show which line your cursor is on
    42|vim.opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor.
    43|
    44|-- [[ Basic Keymaps ]]
    45|--  See `:help vim.keymap.set()`
    46|vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>') -- Clear highlights on search when pressing <Esc> in normal mode. See `:help hlsearch`
    47|vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' }) -- Diagnostic keymaps
    48|-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
    49|-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
    50|-- is not what someone will guess without a bit more experience.
    51|-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
    52|-- or just use <C-\><C-n> to exit terminal mode
    53|vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
    54|--  Use CTRL+<hjkl> to switch between windows. See `:help wincmd` for a list of all window commands
    55|vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
    56|vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
    57|vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
    58|vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
    59|
    60|-- Split screen with cmd-d
    61|vim.keymap.set('n', '<C-d>', ':vsplit<CR>', { desc = 'Split screen vertically' })
    62|vim.keymap.set('n', '<C-S-d>', ':split<CR>', { desc = 'Split screen horizontally' })
    63|
    64|-- Quick Filetype setters for pasted snippets
    65|vim.keymap.set('n', '<leader>ls', '<cmd>set filetype=sql<CR>', { desc = 'Set [L]anguage to [S]QL' })
    66|vim.keymap.set('n', '<leader>lj', '<cmd>set filetype=json<CR>', { desc = 'Set [L]anguage to [J]SON' })
    67|vim.keymap.set('n', '<leader>lp', '<cmd>set filetype=python<CR>', { desc = 'Set [L]anguage to [P]ython' })
    68|vim.keymap.set('n', '<leader>lm', '<cmd>set filetype=markdown<CR>', { desc = 'Set [L]anguage to [M]arkdown' })
    69|
    70|
    71|-- [[ Basic Autocommands ]]
    72|--  See `:help lua-guide-autocommands`
    73|-- Highlight when yanking (copying) text. See `:help vim.highlight.on_yank()`
    74|vim.api.nvim_create_autocmd('TextYankPost', {
    75|  desc = 'Highlight when yanking (copying) text',
    76|  group = vim.api.nvim_create_augroup('zac-highlight-yank', { clear = true }),
    77|  callback = function()
    78|    vim.highlight.on_yank()
    79|  end,
    80|})
    81|
    82|-- [[ Install `lazy.nvim` plugin manager ]]
    83|--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
    84|local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
    85|if not (vim.uv or vim.loop).fs_stat(lazypath) then
    86|  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    87|  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    88|  if vim.v.shell_error ~= 0 then
    89|    error('Error cloning lazy.nvim:\n' .. out)
    90|  end
    91|end ---@diagnostic disable-next-line: undefined-field
    92|vim.opt.rtp:prepend(lazypath)
    93|
    94|-- [[ Configure and install plugins ]]
    95|--  To check the current status of your plugins, run :Lazy
    96|-- Use `opts = {}` to force a plugin to be loaded.
    97|-- NOTE: Here is where you install your plugins.
    98|require('lazy').setup({
    99|  { import = 'plugins.coding' },
   100|  { import = 'plugins.editor' },
   101|  { import = 'plugins.git' },
   102|  { import = 'plugins.tools' },
   103|  { import = 'plugins.ui' },
   104|}, {
   105|  ui = {
   106|    -- If you are using a Nerd Font: set icons to an empty table which will use the
   107|    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
   108|    icons = vim.g.have_nerd_font and {} or {
   109|      cmd = '⌘',
   110|      config = '🛠',
   111|      event = '📅',
   112|      ft = '📂',
   113|      init = '⚙',
   114|      keys = '🗝',
   115|      plugin = '🔌',
   116|      runtime = '💻',
   117|      require = '🌙',
   118|      source = '📄',
   119|      start = '🚀',
   120|      task = '📌',
   121|      lazy = '💤 ',
   122|    },
   123|  },
   124|})
   125|
   126|-- Automatically switch colorscheme based on background mode
   127|local function set_colorscheme()
   128|  if vim.o.background == 'dark' then
   129|    vim.cmd.colorscheme 'ayu'
   130|  else
   131|    vim.cmd.colorscheme 'rose-pine-dawn'
   132|  end
   133|end
   134|
   135|-- Set colorscheme on startup
   136|set_colorscheme()
   137|
   138|-- Update colorscheme when background changes
   139|vim.api.nvim_create_autocmd('OptionSet', {
   140|  pattern = 'background',
   141|  callback = set_colorscheme,
   142|})
   143|
   144|
   145|-- The line beneath this is called `modeline`. See `:help modeline`
   146|-- vim: ts=2 sts=2 sw=2 et
   147|