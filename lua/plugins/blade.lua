return {
  -- 1. Voeg de Blade parser handmatig toe aan Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- Haal de parsers tabel op de juiste manier op
      local parsers = require("nvim-treesitter.parsers")

      parsers.blade = {
        install_info = {
          url = "https://github.com",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "blade",
      }

      -- Zorg dat Treesitter de talen automatisch installeert
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "html", "php", "php_only", "blade" })
      end
    end,
  },

  -- 2. Koppel HTML autocomplete (LSP) aan je Blade bestanden
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = {
          filetypes = { "html", "blade" },
        },
      },
    },
  },
}
