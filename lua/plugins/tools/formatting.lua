return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function() require('conform').format { async = true, lsp_format = 'fallback' } end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        local lsp_format_opt = disable_filetypes[vim.bo[bufnr].filetype] and 'never' or 'fallback'
        return { timeout_ms = 500, lsp_format = lsp_format_opt }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'ruff' },
        sql = { 'sqlfluff' },
        json = { 'jq', 'prettierd', 'prettier', stop_after_first = true },
        markdown = { 'markdownlint' },
        html = { 'prettierd', 'prettier', stop_after_first = true },
        yaml = { 'prettierd', 'prettier', stop_after_first = true },
        sh = { 'shfmt' },
      },
    },
  },
}
