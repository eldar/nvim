return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
      settings = {
        save_on_toggle = true,
      },
    },
    -- stylua: ignore
    keys = {
      { '<Leader>ha', function() require('harpoon'):list():add() end, desc = 'Add Location' },
      { '<Leader>hr', function() require('harpoon'):list():remove() end, desc = 'Remove Location' },
      { '<C-n>', function() require('harpoon'):list():next() end, desc = 'Next Location' },
      { '<C-p>', function() require('harpoon'):list():prev() end, desc = 'Previous Location' },
      { '<Leader>1', function() require('harpoon'):list():select(1) end, desc = 'Harpoon to File 1' },
      { '<Leader>2', function() require('harpoon'):list():select(2) end, desc = 'Harpoon to File 2' },
      { '<Leader>3', function() require('harpoon'):list():select(3) end, desc = 'Harpoon to File 3' },
      { '<Leader>4', function() require('harpoon'):list():select(4) end, desc = 'Harpoon to File 4' },
      { '<Leader>5', function() require('harpoon'):list():select(5) end, desc = 'Harpoon to File 5' },

      { '<Leader>hh', function()
        local harpoon = require('harpoon')
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, desc = 'List locations' },
    },
  },
  {
    "letieu/harpoon-lualine",
    dependencies = {
      {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
      }
    },
  }
}
