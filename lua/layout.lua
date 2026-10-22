-- ~/.config/nvim/lua/layout.lua
local M = {}
local api = vim.api

local TREE_WIDTH = 40
local TERM_HEIGHT = 15

M.wins = {}
M.bufs = {}

local function valid(win)
  return win and api.nvim_win_is_valid(win)
end

local function tree_win()
  for _, win in ipairs(api.nvim_tabpage_list_wins(0)) do
    if vim.bo[api.nvim_win_get_buf(win)].filetype == "neo-tree" then
      return win
    end
  end
end

-- terminal in huidig venster; hergebruikt bestaande terminal bij reset
local function term_here(key)
  local b = M.bufs[key]
  if b and api.nvim_buf_is_valid(b) then
    api.nvim_win_set_buf(0, b)
  else
    vim.cmd("terminal")
    M.bufs[key] = api.nvim_get_current_buf()
  end
  local win = api.nvim_get_current_win()
  vim.wo[win].number = false
  vim.wo[win].relativenumber = false
  vim.wo[win].winfixheight = true
  return win
end

function M.resize()
  local t = tree_win()
  if t then
    api.nvim_win_set_width(t, TREE_WIDTH)
  end
  local t1, t2 = M.wins.term1, M.wins.term2
  if valid(t1) then
    api.nvim_win_set_height(t1, TERM_HEIGHT)
  end
  if valid(t1) and valid(t2) then
    local total = api.nvim_win_get_width(t1) + api.nvim_win_get_width(t2)
    api.nvim_win_set_width(t1, math.floor(total / 2))
  end
end

function M.build()
  pcall(vim.cmd, "Neotree close")
  vim.cmd("silent! only")

  -- codevenster: lege buffer als het een map/speciale buffer is
  local buf = api.nvim_get_current_buf()
  if vim.bo[buf].buftype ~= "" or vim.fn.isdirectory(api.nvim_buf_get_name(buf)) == 1 then
    vim.cmd("enew")
  end
  M.wins.code = api.nvim_get_current_win()

  -- twee terminals onder de code
  vim.cmd("botright " .. TERM_HEIGHT .. "split")
  M.wins.term1 = term_here("term1")
  vim.cmd("vsplit")
  M.wins.term2 = term_here("term2")

  -- terminals vastzetten: er kan geen andere buffer meer in
  if vim.fn.has("nvim-0.10") == 1 then
    vim.wo[M.wins.term1].winfixbuf = true
    vim.wo[M.wins.term2].winfixbuf = true
  end

  -- neo-tree links over de volle hoogte
  api.nvim_set_current_win(M.wins.code)
  vim.cmd("Neotree show left")
  vim.schedule(function()
    local t = tree_win()
    if t then
      vim.wo[t].winfixwidth = true
    end
    M.resize()
    if valid(M.wins.code) then
      api.nvim_set_current_win(M.wins.code)
    end
  end)
end

function M.focus(name)
  local get = function()
    return name == "tree" and tree_win() or M.wins[name]
  end
  local win = get()
  if not valid(win) then -- venster weg? layout herstellen
    M.build()
    vim.schedule(function()
      M.focus(name)
    end)
    return
  end
  api.nvim_set_current_win(win)
  if name:find("term") then
    vim.cmd("startinsert")
  end
end

function M.setup()
  vim.o.equalalways = false -- niet alles gelijk trekken bij splitten/sluiten

  local names = { "tree", "code", "term1", "term2" }
  for i, name in ipairs(names) do
    local fn = function()
      M.focus(name)
    end
    -- normal mode: 1 t/m 4
    vim.keymap.set("n", tostring(i), fn, { desc = "Focus " .. name })
    -- overal (ook vanuit terminal/insert): Alt+1 t/m Alt+4
    vim.keymap.set("n", "<A-" .. i .. ">", fn, { desc = "Focus " .. name })
    vim.keymap.set(
      { "t", "i" },
      "<A-" .. i .. ">",
      "<C-\\><C-n><Cmd>lua require('layout').focus('" .. name .. "')<CR>",
      { desc = "Focus " .. name }
    )
  end

  vim.api.nvim_create_user_command("LayoutReset", M.build, {})
  vim.keymap.set("n", "<leader>L", M.build, { desc = "Layout resetten" })

  vim.api.nvim_create_autocmd("VimResized", { callback = M.resize })

  -- automatisch opbouwen bij `nvim` of `nvim .`
  local function auto()
    local argv0 = vim.fn.argv(0)
    if vim.fn.argc() == 0 or vim.fn.isdirectory(argv0) == 1 then
      vim.schedule(M.build)
    end
  end
  if vim.v.vim_did_enter == 1 then
    auto()
  else
    vim.api.nvim_create_autocmd("VimEnter", { once = true, callback = auto })
  end
end

return M
