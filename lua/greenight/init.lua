local palette = require 'greenight.palette'
local get_highlights = require 'greenight.highlights'

local M = {}

function M.apply_colors()
  vim.cmd 'hi clear'
  if vim.fn.exists 'syntax_on' then
    vim.cmd 'syntax reset'
  end

  local highlight_options = get_highlights(palette)

  vim.o.termguicolors = true
  vim.o.background = 'dark'

  for group, color in pairs(highlight_options) do
    vim.api.nvim_set_hl(0, group, {
      fg = color.fg,
      bg = color.bg,
      sp = color.sp,
      bold = color.bold,
      underline = color.underline,
      italic = color.italic,
      undercurl = color.undercurl,
    })
  end
end

M.setup = function()
  M.apply_colors()
end

return M
