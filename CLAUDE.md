# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a **Kickstart.nvim-based** Neovim configuration tailored for data engineering work (BigQuery, dbt, Python). It uses lazy.nvim for plugin management with lazy-loading for fast startup.

## Architecture

```
init.lua                    # Main config: options, keymaps, core plugins (~780 lines)
lua/
├── kickstart/plugins/      # Core plugin specs (lint, gitsigns, neo-tree, etc.)
└── custom/
    ├── plugins/            # User plugins (bigquery, copilot, dataform)
    └── snippets/           # LuaSnip snippets (sqlx.lua for Dataform)
```

**Extension pattern**: Add new plugins to `lua/custom/plugins/` as separate files returning lazy.nvim specs. They're auto-imported via `{ import = 'custom.plugins' }`.

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

## Custom BigQuery Plugin

Located at `lua/custom/plugins/bigquery.lua`. Provides:
- `:QueryCost` / `<leader>qe` - Dry-run to estimate query cost
- `:CompileQuery` / `<leader>qc` - Compile Dataform query
- `:BQRun` / `<leader>qq` - Execute query, show results in split

Uses async `vim.fn.jobstart()` for non-blocking execution.

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
