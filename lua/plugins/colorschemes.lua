return {
  {
    dir = 'lua/nana/',
    name = 'nana',
    priority = 100,
    config = function()
      require('nana').setup()
    end,
  },
}
