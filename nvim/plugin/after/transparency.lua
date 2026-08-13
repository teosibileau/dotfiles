local groups = {
  "Normal",
  "NormalNC",
  "NormalFloat",
  "FloatBorder",
  "FloatTitle",
  "SignColumn",
  "StatusLine",
  "StatusLineNC",
  "TabLine",
  "TabLineFill",
  "WinBar",
  "WinBarNC",
  "WinSeparator",
  "LineNr",
  "CursorLineNr",
  "EndOfBuffer",
  "FoldColumn",
  "Folded",
  "VertSplit",
  "NeoTreeNormal",
  "NeoTreeNormalNC",
  "NeoTreeEndOfBuffer",
  "NeoTreeWinSeparator",
  "NeoTreeStatusLine",
  "NeoTreeStatusLineNC",
  "NeoTreeVertSplit",
  "NeoTreeTabActive",
  "NeoTreeTabInactive",
  "NeoTreeTabSeparatorActive",
  "NeoTreeTabSeparatorInactive",
  "NotifyBackground",
  "TelescopeNormal",
  "TelescopeBorder",
  "TelescopePromptNormal",
  "TelescopePromptBorder",
  "TelescopeResultsNormal",
  "TelescopeResultsBorder",
  "TelescopePreviewNormal",
  "TelescopePreviewBorder",
}

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    for _, group in ipairs(groups) do
      pcall(vim.api.nvim_set_hl, 0, group, { bg = "NONE", ctermbg = "NONE" })
    end
  end,
})

-- Apply immediately for the current colorscheme
for _, group in ipairs(groups) do
  pcall(vim.api.nvim_set_hl, 0, group, { bg = "NONE", ctermbg = "NONE" })
end
