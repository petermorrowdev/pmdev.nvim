local all_palettes = require 'nana.palette' -- Get both palettes
local get_highlights = require 'nana.highlights' -- The function to get highlights for a palette

local M = {}

-- Define a function to apply the colorscheme based on the current background
function M.apply_colors()
  vim.cmd 'hi clear'
  if vim.fn.exists 'syntax_on' then
    vim.cmd 'syntax reset'
  end

  local current_background = vim.o.background or 'dark'

  local active_palette
  if current_background == 'light' then
    active_palette = all_palettes.light
  else
    active_palette = all_palettes.dark
  end

  local highlight_options = get_highlights(active_palette)

  vim.o.termguicolors = true
  vim.o.background = current_background

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
  -- Apply the colorscheme for the first time
  M.apply_colors()

  -- Create an autocommand to re-apply the colorscheme when the 'background' option changes
  vim.api.nvim_create_autocmd('OptionSet', {
    pattern = 'background',
    callback = function()
      M.apply_colors()
    end,
  })
end

return M
