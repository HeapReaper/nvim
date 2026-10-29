-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Alt+A = left
vim.keymap.set("i", "<M-a>", "<Left>")

-- Alt+D = right
vim.keymap.set("i", "<M-d>", "<Right>")

-- Alt+W = up
vim.keymap.set("i", "<M-w>", "<Up>")

-- Alt+S = down
vim.keymap.set("i", "<M-s>", "<Down>")

-- Exit insert with alt e
vim.keymap.set("i", "<M-e>", "<Esc>")

-- Exit mode with alt e
vim.keymap.set("t", "<M-e>", [[<C-\><C-n>]])

-- Exit terminal mode with Escape
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], {
  desc = "Exit terminal mode",
})

-- Search text in the whole project with Ctrl+F
vim.keymap.set("n", "<C-f>", LazyVim.pick("grep"), {
  desc = "Grep (Root Dir)",
})

-- Restore layout (neo-tree | code | 2 terminals) with <leader>L
-- set here so it overrides LazyVim's default <leader>L (changelog)
vim.keymap.set("n", "<leader>L", function()
  require("layout").build()
end, { desc = "Layout herstellen" })
