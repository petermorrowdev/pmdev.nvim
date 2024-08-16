local highlight_options = require 'nana.highlights'

local M = {}

M.setup = function()
  vim.cmd 'hi clear'
  if vim.fn.exists 'syntax_on' then
    vim.cmd 'syntax reset'
  end
  vim.o.background = 'dark'
  vim.o.termguicolors = true

  for group, color in pairs(highlight_options) do
    vim.api.nvim_set_hl(
      0,
      group,
      { fg = color.fg, bg = color.bg, sp = color.sp, bold = color.bold, underline = color.underline, italic = color.italic, undercurl = color.undercurl }
    )
  end
end

return M
