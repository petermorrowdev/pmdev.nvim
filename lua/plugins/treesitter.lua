return { -- Highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
      local parsers = {
        'bash',
        'c',
        'dockerfile',
        'hcl',
        'html',
        'json',
        'lua',
        'markdown',
        'markdown_inline',
        'python',
        'sql',
        'toml',
        'vim',
        'vimdoc',
      }

      require('nvim-treesitter').install(parsers)

      vim.api.nvim_create_autocmd('FileType', {
        pattern = parsers,
        callback = function()
          vim.treesitter.start()
        end,
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    config = function()
      require('nvim-treesitter-textobjects').setup {
        select = {
          lookahead = true,
        },
      }

      local ts_select = require 'nvim-treesitter-textobjects.select'
      local keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      }
      for key, query in pairs(keymaps) do
        vim.keymap.set({ 'x', 'o' }, key, function()
          ts_select.select_textobject(query, 'textobjects')
        end)
      end
    end,
  },
}
