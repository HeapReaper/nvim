local function my_layout()
  vim.cmd("Neotree show")

  -- Focus naar editor
  vim.cmd("wincmd l")

  -- Horizontale split onderaan
  vim.cmd("belowright split")
  vim.cmd("resize 10")
  vim.cmd("terminal")

  -- Rechter terminal
  vim.cmd("vsplit")
  vim.cmd("terminal")

  -- Beide terminals hoogte 10
  vim.cmd("wincmd =")
  vim.cmd("resize 10")

  -- Terug naar editor
  vim.cmd("wincmd k")
end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.schedule(my_layout)
  end,
})

require("config.layout")

-- Prevents mini.files opening when opening a map with nvim .
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
