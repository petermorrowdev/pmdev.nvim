local M = {}

local function buf_display_name(buf)
  if buf.name and buf.name ~= '' then
    return vim.fn.fnamemodify(buf.name, ':.')
  end
  return string.format('[No Name #%d]', buf.bufnr)
end

local function delete_buffer(bufnr, opts)
  return pcall(vim.api.nvim_buf_delete, bufnr, opts or {})
end

function M.close_current()
  local current = vim.api.nvim_get_current_buf()
  local ok, err = delete_buffer(current, {})
  if not ok then
    vim.notify(err, vim.log.levels.ERROR, { title = 'Buffer hygiene' })
  end
end

function M.close_others()
  local current = vim.api.nvim_get_current_buf()
  local view = vim.fn.winsaveview()
  local skipped = {}
  local closed = {}

  for _, buf in ipairs(vim.fn.getbufinfo { buflisted = 1 }) do
    if buf.bufnr ~= current then
      if buf.changed ~= 0 then
        table.insert(skipped, buf_display_name(buf))
      else
        if delete_buffer(buf.bufnr, {}) then
          table.insert(closed, buf_display_name(buf))
        end
      end
    end
  end

  if vim.api.nvim_buf_is_valid(current) then
    vim.api.nvim_set_current_buf(current)
  end

  vim.fn.winrestview(view)

  if #skipped > 0 then
    vim.notify(
      ('Skipped %d modified buffer(s):\n%s'):format(#skipped, table.concat(skipped, '\n')),
      vim.log.levels.WARN,
      { title = 'Buffer hygiene' }
    )
  elseif #closed > 0 then
    vim.notify(
      ('Closed %d buffer(s):\n%s'):format(#closed, table.concat(closed, '\n')),
      vim.log.levels.INFO,
      { title = 'Buffer hygiene' }
    )
  end
end

return M
