local palettes = require 'nana.palette'

local current_background = vim.o.background or 'dark'
local colors = (current_background == 'light') and palettes.light or palettes.dark

return {
  inactive = {
    a = { fg = colors.grey, bg = colors.base1 },
    b = { fg = colors.grey, bg = colors.base1 },
    c = { fg = colors.grey, bg = colors.base1 },
  },
  normal = {
    a = { fg = colors.grey, bg = colors.base1 },
    b = { fg = colors.grey, bg = colors.base1 },
    c = { fg = colors.grey, bg = colors.base1 },
  },
  visual = { a = {
    fg = colors.black,
    bg = colors.yellow,
  } },
  replace = { a = { fg = colors.black, bg = colors.red, gui = 'bold' } },
  insert = { a = { fg = colors.black, bg = colors.green } },
  command = { a = { fg = colors.black, bg = colors.orange } },
  terminal = { a = { fg = colors.black, bg = colors.blue, gui = 'bold' } },
}
