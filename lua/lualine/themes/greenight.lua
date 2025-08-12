local colors = require 'greenight.palette'

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
