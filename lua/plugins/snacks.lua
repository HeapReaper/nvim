return {
  {
    "folke/snacks.nvim",
    opts = {
      -- Schakel de snacks file explorer volledig uit bij het opstarten van een map
      explorer = {
        enabled = false,
      },
      -- Dit zorgt ervoor dat de snacks picker mappen niet kaapt
      picker = {
        sources = {
          explorer = {
            enabled = false,
          },
        },
      },
    },
  },
}
