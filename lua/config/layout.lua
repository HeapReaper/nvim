local function setup_layout()
  -- Neo-tree links openen
  vim.cmd("Neotree filesystem show left")

  -- Even wachten tot Neo-tree zijn window heeft gemaakt
  vim.defer_fn(function()
    -- Terminal onderaan
    vim.cmd("botright split")
    vim.cmd("resize 12")
    vim.cmd("terminal")

    -- Terug naar de code
    vim.cmd("wincmd k")
  end, 100)
end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = setup_layout,
})
