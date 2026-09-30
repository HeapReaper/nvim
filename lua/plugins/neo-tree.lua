return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        visible = true, -- Toon verborgen items vervaagd in plaats van ze helemaal te verbergen
        hide_dotfiles = false,
        hide_gitignored = false,
      },
    },
  },
}
