-- vim.cmd.colorscheme("tokyonight")

-- vim.g.sonokai_style = "default"
-- vim.g.sonokai_enable_italic = 1
-- vim.g.sonokai_better_performance = 1
-- vim.cmd.colorscheme("sonokai")

-- vim.cmd.colorscheme("kanagawa-wave")

-- vim.cmd.colorscheme("carbonfox")

-- vim.o.background = "dark"
-- vim.cmd.colorscheme("vscode")

-- vim.cmd.colorscheme("melange")

-- require("catppuccin").setup({
--     flavour = "mocha", -- latte, frappe, macchiato, mocha
-- })
-- vim.cmd.colorscheme("catppuccin")

vim.g.everforest_background = "hard"
vim.g.everforest_current_word = "grey background" -- "underline" 
vim.g.everforest_diagnostic_text_highlight = 1
vim.g.everforest_diagnostic_virtual_text = "colored"
-- vim.g.everforest_diagnostic_line_highlight = 1
vim.g.everforest_better_performance = 1

vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('custom_highlights_everforest', {}),
  pattern = 'everforest',
  callback = function()
    local config = vim.fn['everforest#get_configuration']()
    local palette = vim.fn['everforest#get_palette'](config.background, config.colors_override)
    local set_hl = vim.fn['everforest#highlight']

    set_hl('CurrentWord', palette.none, palette.bg3)
  end
})

vim.cmd.colorscheme("everforest")