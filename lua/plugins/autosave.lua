return {
  "okuuva/auto-save.nvim",
  config = function()
    require("auto-save").setup({
      enabled = true,
      execution_message = {
        enabled = false,
      },
      trigger_events = {
        immediate_save = { "BufLeave", "FocusLost" },
        defer_save = { "InsertLeave", "TextChanged" },
      },
    })
  end,
}
