# Zac's Neovim Config

A modular, highly customized [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)-based configuration tailored specifically for **Data Engineering** (Python, BigQuery, dbt, Bash).

## 🚀 Key Features

* **AI Ghost Text:** BYOK (Bring Your Own Key) Copilot-style completion via [`minuet-ai.nvim`](https://github.com/milanglacier/minuet-ai.nvim) powered by Google's Gemini 3.1 Pro.
* **Data Engineering Focus:**
  * **Python:** Uses Astral's [`ty`](https://github.com/astral-sh/ty) for blazing-fast LSP type-checking and `ruff` for formatting.
  * **SQL / dbt:** Configured with `sqlfluff` for native linting/formatting (picks up `.sqlfluff` rules automatically) and a custom `dbt-language-server`.
  * **Shell / Configs:** Native support for `.sh`, `.env`, and `.toml` using `bash-language-server`, `shellcheck`, `shfmt`, and `taplo`.
* **Domain-Driven Architecture:** Plugins are strictly organized by their purpose (UI, Tools, Coding, Editor, Git) for easy debugging and modularity.
* **modularity:** Along with Domina driven above, we keep `init.lua` clean by breaking keymapping and settings to the /core directory

## 📂 Architecture & Plugins

### Core

The `lua/core/` directory contains contains the foundational configurations:

* `options.lua`: Sets global Vim options (line numbers, search behavior, tabs).
* `keymaps.lua`: Defines global non-plugin shortcuts and system clipboard integrations.
* `autocmds.lua`: Defines automatic actions (e.g., highlighting yanked text, auto-formatting).
* `lazy.lua`: Lazy's config setup. Yes a plugin but core to setting up all later plugins so have put here.

### Plugins

The `lua/plugins/` directory is recursively loaded by `lazy.nvim`. It is split into 5 core domains:

#### 1. `coding/` (Code writing & AI)

* `completion.lua` (`blink.cmp`): Lightning-fast, non-blocking autocomplete engine.
* `ai.lua` (`minuet-ai.nvim`): BYOK Gemini 3.1 Pro ghost-text inline suggestions.
* `autopairs.lua` (`nvim-autopairs`): Automatically closes brackets and quotes as you type.

#### 2. `tools/` (Smarts, LSPs & External binaries)

* `lsp.lua` (`mason` & `lspconfig`): Smart language features (Go-to-definition, hover docs) and binary package management (ty, dbt-ls).
* `formatting.lua` (`conform.nvim`): Auto-formats code on save (sqlfluff, ruff, shfmt).
* `linting.lua` (`nvim-lint`): Asynchronous background linting for catching bugs (shellcheck, markdownlint).
* `markdown_preview.lua`: Live browser rendering of Markdown files.

#### 3. `editor/` (Navigation & Search)

* `search.lua` (`telescope.nvim`): Fuzzy finding for files, grep search, and LSP symbols.
* `syntax.lua` (`nvim-treesitter`): Advanced AST-based syntax highlighting and code parsing.
* `keymaps.lua` (`which-key.nvim`): Popup helper for discovering available keymaps.

#### 4. `ui/` (Aesthetics & Interface)

* `core.lua` (`mini.nvim`, themes): Statusline, text-objects, and Ayu/Rose-pine colorschemes.
* `explorer.lua` (`neo-tree.nvim`): Sidebar file tree explorer.
* `indent.lua` (`indent-blankline`): Dotted vertical lines to show indentation depth.

#### 5. `git/` (Source Control)

* `signs.lua` (`gitsigns.nvim`): Inline Git blame and gutter diff indicators.

## ⌨️ Custom Workflows

### Language Quick-Select

When pasting raw snippets into an empty buffer, use the custom `[L]anguage` group:

* `<leader>ls` -> Set filetype to **SQL**
* `<leader>lj` -> Set filetype to **JSON**
* `<leader>lp` -> Set filetype to **Python**
* `<leader>lm` -> Set filetype to **Markdown**

### AI Completion (Minuet)

* `Ctrl + y` -> Accept suggestion
* `Ctrl + a` -> Accept next line
* `Ctrl + e` -> Dismiss suggestion

## ⚙️ Setup Requirements

1. **Python Environment:** The config looks for a global Neovim Python host at `~/.config/python-neovim/.venv/bin/python3`.
2. **AI API Key:** Export `GOOGLE_API_KEY` in your shell (e.g., `~/.zshrc`) for Minuet AI to function.
3. **dbt LSP:** Expects `dbt-language-server` installed at `~/.local/bin/dbt-language-server`.

---
*Based on Kickstart.nvim*
