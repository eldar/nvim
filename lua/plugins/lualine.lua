return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      component_separators = { left = '', right = '' },
      sections = {
        -- Other Status Line components
        -- lualine_a = { ... },
        lualine_b = {
          {
            "filename",
            path = 1,
          },
        },
        lualine_c = {
          {
            '%=',
            separator = { left = "", right = ""},
          },
          {
            "harpoon2",
          }
        },
        lualine_x = {'filetype'},
        -- lualine_c = {
        --   {
        --     function()
        --       -- invoke `progress` here.
        --       return require('lsp-progress').progress()
        --     end,
        --   },
        -- },
      }
    }
  },
}
