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
      vue = { 'prettierd' },
      typescript = { 'prettierd' },
      typescriptreact = { 'prettierd' },
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
