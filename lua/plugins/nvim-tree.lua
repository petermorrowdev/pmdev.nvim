return {
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup {
        sort_by = 'case_sensitive',
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
          icons = {
            git_placement = 'before',
            glyphs = {
              git = {
                unstaged = '●',
                staged = '✓',
                unmerged = '◐',
                renamed = '→',
                untracked = '◯',
                deleted = '✖',
                ignored = '◌',
              },
            },
          },
        },
        filters = {
          dotfiles = false,
        },
        update_focused_file = {
          enable = true,
          update_cwd = true,
        },
      }
    end,
  },
  {
    'antosha417/nvim-lsp-file-operations',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-tree.lua',
    },
    config = function()
      require('lsp-file-operations').setup()
    end,
  },
}
