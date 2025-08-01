return {
  {
    dir = '~/.config/nvim/lua/nana/',
    name = 'nana',
    priority = 100,
    config = function()
      require('nana').setup()
    end,
  },
}
