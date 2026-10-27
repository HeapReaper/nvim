-- Free up Ctrl+F for project search (see config/keymaps.lua)
return {
  "folke/noice.nvim",
  keys = {
    { "<c-f>", false, mode = { "i", "n", "s" } },
  },
}
