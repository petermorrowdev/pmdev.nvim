return {
  'nvim-tree/nvim-web-devicons',
  enabled = vim.g.have_nerd_font,
  opts = {
    default = true,
    override = {
      css = {
        -- CSS icon is broken, showing 歓 not sure why
        icon = '',
        color = '#3ca5d6',
        name = 'Css',
      },
    },
  },
}
