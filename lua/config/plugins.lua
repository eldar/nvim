require("telescope").setup({
  defaults = {
    sorting_strategy = "ascending",
    layout_config = {prompt_position = "top"},
    mappings = {
      n = {
        ['<c-d>'] = require('telescope.actions').delete_buffer
      }, -- n
      i = {
        ['<c-d>'] = require('telescope.actions').delete_buffer
      } -- i
    } -- mappings
  }
})

-- require('mini.cursorword').setup()
