return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      sections = {
        -- Other Status Line components
        -- lualine_a = { ... },
        lualine_b = {
          {
            "filename",
            path = 1,
          }
        },
        lualine_c = {
          {
            "harpoon2",
            -- icon = '',
          }
        },
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
