return {
  'nvim-lualine/lualine.nvim',
  opts = {
    options = {
      icons_enabled = vim.g.have_nerd_font,
      theme = 'greenight',
      component_separators = '',
      section_separators = '',
    },
    sections = {
      lualine_b = {
        {
          'branch',
          fmt = function(str)
            if #str > 20 then
              return str:sub(1, 32) .. '...'
            end
            return str
          end,
        },
        'diff',
        'diagnostics',
      },
    },
  },
}
