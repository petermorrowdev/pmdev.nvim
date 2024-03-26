local colors = require 'nana.palette'

return {
  inactive = {
    a = { fg = colors.gray, bg = colors.base1 },
    b = { fg = colors.gray, bg = colors.base1 },
    c = { fg = colors.gray, bg = nil }, -- transparent
  },
  normal = {
    a = { fg = colors.grey, bg = colors.basehighlight },
    b = { fg = colors.grey, bg = colors.base2 },
    c = { fg = colors.grey, bg = nil }, -- transparent
  },
  visual = { a = { fg = colors.black, bg = colors.yellow } },
  replace = { a = { fg = colors.black, bg = colors.red, gui = 'bold' } },
  insert = { a = { fg = colors.black, bg = colors.green } },
  command = { a = { fg = colors.black, bg = colors.orange } },
  terminal = { a = { fg = colors.black, bg = colors.blue, gui = 'bold' } },
}
