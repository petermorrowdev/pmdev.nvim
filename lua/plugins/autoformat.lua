return {
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = false,
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      css = { 'oxfmt' },
      html = { 'oxfmt' },
      javascript = { 'oxfmt' },
      javascriptreact = { 'oxfmt' },
      json = { 'oxfmt' },
      jsonc = { 'oxfmt' },
      typescript = { 'oxfmt' },
      typescriptreact = { 'oxfmt' },
      vue = { 'oxfmt' },
      python = { 'ruff_format' },
    },
  },
  config = function(_, opts)
    require('conform').setup(opts)

    vim.keymap.set('n', '<leader>l', function()
      require('conform').format({
        formatters = { 'ruff_fix' },
        timeout_ms = 500,
      })
    end, { desc = '[L]int fix with ruff' })
  end,
}
