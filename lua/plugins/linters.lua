return {
  'mfussenegger/nvim-lint',
  config = function()
    local lint = require 'lint'
    lint.linters_by_ft = {
      python = { 'mypy' },
    }
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePre', 'BufWritePost', 'TextChanged', 'InsertLeave' }, {
      callback = function()
        lint.try_lint(nil, { ignore_errors = true })
      end,
    })
  end,
}
