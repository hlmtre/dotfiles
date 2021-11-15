local M = {}

function M.lint_lsp()
  local lsp_status = require('lsp-status')
  local result = ''
  if #vim.lsp.buf_get_clients(0) > 0 then
    result = result .. lsp_status.status()
  end
  return result
end

function M.lsp_progress()
  local messages = vim.lsp.util.get_progress_messages()
  if #messages == 0 then
    return
  end
  local status = {}
  for _, msg in pairs(messages) do
    table.insert(status, (msg.percentage or 0) .. "%% " .. (msg.title or ""))
  end
  local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
  local ms = vim.loop.hrtime() / 1000000
  local frame = math.floor(ms / 120) % #spinners
  return table.concat(status, " | ") .. " " .. spinners[frame + 1]
end

function M.prename()
  local rename = "textDocument/rename"
  local currName = vim.fn.expand("<cword>")
  local tshl = require("nvim-treesitter-playground.hl-info").get_treesitter_hl()
  if tshl and #tshl > 0 then
    local ind = tshl[#tshl]:match("^.*()%*%*.*%*%*")
    tshl = tshl[#tshl]:sub(ind + 2, -3)
  end

  local win = require('plenary.popup').create(currName, {
    title = "New Name",
    style = "minimal",
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    relative = "cursor",
    borderhighlight = "FloatBorder",
    titlehighlight = "Title",
    highlight = tshl,
    focusable = true,
    width = 25,
    height = 1,
    line = "cursor+2",
    col = "cursor-1"
  })

  local map_opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(0, "i", "<Esc>", "<cmd>stopinsert | q!<CR>", map_opts)
  vim.api.nvim_buf_set_keymap(0, "n", "<Esc>", "<cmd>stopinsert | q!<CR>", map_opts)
  vim.api.nvim_buf_set_keymap(0, "i", "<CR>", "<cmd>stopinsert | lua _rename('"..currName.."')<CR>", map_opts)
  vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "<cmd>stopinsert | lua _rename('"..currName.."')<CR>", map_opts)

  local function handler(err, result, ctx, config)
    if err then vim.notify(("Error running lsp query '%s': %s"):format(rename, err), vim.log.levels.ERROR) end
    local new
    if result and result.changes then
      local msg = ""
      for f, c in pairs(result.changes) do
        new = c[1].newText
        msg = msg..("%d changes -> %s"):format(#c, f:gsub("file://",""):gsub(vim.fn.getcwd(),".")).."\n"
        msg = msg:sub(1, #msg - 1)
        vim.notify(msg, vim.log.levels.INFO, { title = ("Rename: %s -> %s"):format(currName, new) })
      end
    end
    vim.lsp.handlers[rename](err, result, ctx, config)
  end

  function M._rename(curr)
    local newName = vim.trim(vim.fn.getline('.'))
    vim.api.nvim_win_close(win, true)
    if #newName > 0 and newName ~= curr then
      local params = vim.lsp.util.make_position_params()
      params.newName = newName
      vim.lsp.buf_request(0, rename, params, handler)
    end
  end
end

function M.dorename(win)
  local new_name = vim.trim(vim.fn.getline('.'))
  vim.api.nvim_win_close(win, true)
  vim.lsp.buf.rename(new_name)
end

function M.rename()
  local opts = {
    relative = 'cursor',
    row = 0,
    col = 0,
    width = 30,
    height = 1,
    style = 'minimal',
    border = 'single'
  }
  local cword = vim.fn.expand('<cword>')
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, opts)
  local fmt =  '<cmd>lua Rename.dorename(%d)<CR>'

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {cword})
  vim.api.nvim_buf_set_keymap(buf, 'i', '<CR>', string.format(fmt, win), {silent=true})
end

return M
