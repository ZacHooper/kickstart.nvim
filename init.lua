-- [[ Global options ]]
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- Python Environment for Plugins
vim.g.python3_host_prog = vim.fn.expand '/Users/zachooper/.config/python-neovim/.venv/bin/python3'

require 'core.settings'
require 'core.keymaps'
require 'core.lazy'
require 'core.autocommands'

-- vim: ts=2 sts=2 sw=2 et
