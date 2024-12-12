return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
      local prose = require("nvim-prose")
      local lualine = require("lualine")
      lualine.setup({
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
          lualine_x = {
            { prose.word_count, cond = prose.is_available },
            'filetype'
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
      })
    end,
    opts = {
    }
  },
}
