# Zac's Neovim Config

A modular, highly customized [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)-based configuration tailored specifically for **Data Engineering** (Python, BigQuery, dbt, Bash).

## 🚀 Key Features

* **AI Ghost Text:** BYOK (Bring Your Own Key) Copilot-style completion via [`minuet-ai.nvim`](https://github.com/milanglacier/minuet-ai.nvim) powered by Google's Gemini 2.5 Pro.
* **Data Engineering Focus:**
  * **Python:** Uses Astral's [`ty`](https://github.com/astral-sh/ty) for blazing-fast LSP type-checking and `ruff` for formatting.
  * **SQL / dbt:** Configured with `sqlfluff` for native linting/formatting (picks up `.sqlfluff` rules automatically) and a custom `dbt-language-server`.
  * **Shell / Configs:** Native support for `.sh`, `.env`, and `.toml` using `bash-language-server`, `shellcheck`, `shfmt`, and `taplo`.
* **Ultra-Fast Autocomplete:** Powered by `blink.cmp` (no command-line lag).
* **Lean & Modular:** No monolithic config. Every plugin lives in its own dedicated file.

## 📂 Architecture

```text
~/.config/nvim/
├── init.lua                 # Core options, baseline keymaps, and autocommands
├── AGENTS.md                # System prompt guidelines for AI agents
├── lua/
│   ├── plugins/             # 🔌 Plugin Specifications (lazy.nvim)
│   │   ├── blink.lua        # Autocompletion engine
│   │   ├── conform.lua      # Formatting on save
│   │   ├── lint.lua         # Async linting
│   │   ├── lsp.lua          # Mason, Language Servers
│   │   ├── minuet.lua       # Gemini AI completion
│   │   ├── telescope.lua    # Fuzzy finding
│   │   ├── treesitter.lua   # Syntax highlighting
│   │   ├── ui.lua           # Colorschemes, status line
│   │   ├── which-key.lua    # Keymap helper
│   │   └── ...
│   └── custom/
│       └── snippets/        # LuaSnip custom snippets
```

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
