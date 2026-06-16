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
        'javascript',
        'json',
        'lua',
        'markdown',
        'markdown_inline',
        'python',
        'sql',
        'toml',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
      }

      require('nvim-treesitter').install(parsers)

      local parser_set = {}
      for _, v in ipairs(parsers) do
        parser_set[v] = true
      end

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          -- if no mapping then return the filetype
          local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
          if lang and parser_set[lang] then
            vim.treesitter.start(args.buf)
          end
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
