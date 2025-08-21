-- add transaction block on save

local function ensure_transaction()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  -- Ensure BEGIN at the top
  if not (lines[1] and lines[1]:match("^BEGIN;$")) then
    table.insert(lines, 1, "")
    table.insert(lines, 1, "BEGIN;")
  elseif not (lines[2] and lines[2]:match("^%s*$")) then
    -- Ensure empty line after BEGIN
    table.insert(lines, 2, "")
  end

  -- Ensure COMMIT at the bottom
  local last = lines[#lines]
  if not (last and last:match("^COMMIT;$")) then
    if last and last:match("^END;%s*$") then
      -- Replace END with COMMIT
      lines[#lines] = "COMMIT;"
    else
      -- Add empty line + COMMIT
      table.insert(lines, "")
      table.insert(lines, "COMMIT;")
    end
  end

  -- Ensure empty line before COMMIT
  local second_last = lines[#lines - 1]
  if not (second_last and second_last:match("^%s*$")) then
    table.insert(lines, #lines, "")
  end

  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("dotvim_transaction-block-on-save", { clear = true }),
  buffer = 0,
  callback = ensure_transaction,
})
