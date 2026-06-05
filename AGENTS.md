# AGENTS.md

This file provides guidance to AI coding agents (Hermes, Claude Code, Cursor, etc.) when working with code in this repository.

## Overview

This is a **Kickstart.nvim-based** Neovim configuration tailored for data engineering work (BigQuery, dbt, Python). It uses lazy.nvim for plugin management with lazy-loading for fast startup.

## Architecture

```text
init.lua                    # Entry point: global options and core module requires
lua/
├── core/                   # Editor fundamentals
│   ├── settings.lua        # vim.opt configurations
│   ├── keymaps.lua         # General keymaps (window splits, filetype setters)
│   ├── autocommands.lua    # Editor-level autocmds (highlight on yank, colorscheme)
│   └── lazy.lua            # lazy.nvim bootstrap and plugin import setup
├── plugins/                # Plugins are grouped by domain (lazy-loaded recursively)
│   ├── coding/             # blink.cmp, minuet-ai, autopairs
│   ├── editor/             # telescope, treesitter, which-key
│   ├── git/                # gitsigns
│   ├── tools/              # lspconfig, conform, nvim-lint
│   └── ui/                 # themes, neo-tree, indent-blankline
└── custom/
    └── snippets/           # Custom LuaSnip snippets
```

**Extension pattern**: Add new plugins to `lua/plugins/` as separate files returning lazy.nvim specs. They're auto-imported via `{ import = 'plugins' }`.

## Key Tools & Setup

**LSP servers** (configured in init.lua `servers` table around line 445):
- `basedpyright`: Python (uses `.venv/bin/python`)
- `lua_ls`: Lua
- `dbt_ls`: Custom dbt-language-server at `~/.local/bin/dbt-language-server` (understands Jinja templating)

**Formatting** (conform.nvim):
- Lua: `stylua`
- Python: `ruff`
- SQL: `sql_formatter` (BigQuery dialect)

**Linting** (nvim-lint):
- SQL: `sqlfluff` (configured for dbt/BigQuery in project `.sqlfluff`)
- Markdown: `markdownlint`

**Completion**: blink.cmp with LuaSnip

## Key Keymaps

| Keys | Action |
|------|--------|
| `<leader>` | Space |
| `\\` | Toggle neo-tree |
| `<leader>sf` | Find files (Telescope) |
| `<leader>sg` | Live grep |
| `gd` | Go to definition |
| `gr` | Go to references |
| `<leader>f` | Format buffer |
| `<leader>ac` | Toggle CodeCompanion chat |

## Adding New Functionality

**New plugin**: Create `lua/custom/plugins/myplugin.lua`:
```lua
return {
  'author/plugin',
  event = 'VimEnter',  -- or ft, cmd, keys for lazy-loading
  opts = {},
}
```

**New LSP server**: Add to `servers` table in init.lua, optionally add to `ensure_installed` for Mason auto-install.

**New snippet**: Add to `lua/custom/snippets/`, require in init.lua.

## Commands

```bash
# Sync plugins after config changes
:Lazy sync

# Install/update LSP servers
:Mason

# Check LSP status for current buffer
:LspInfo

# Check formatter status
:ConformInfo
```

## Notes

- Python host: `~/.config/python-neovim/.venv/bin/python3`
- Dark/light mode auto-switches based on system setting (rose-pine-dawn / ayu)
- Nerd Font icons enabled (`vim.g.have_nerd_font = true`)
