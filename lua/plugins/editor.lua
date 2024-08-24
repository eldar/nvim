return {
  {
    'echasnovski/mini.cursorword',
    enabled = true,
    version = '*',
    opts = {
      -- Delay (in ms) between when cursor moved and when highlighting appeared
      delay = 250, -- same as updatetime
    }
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {}
  },
}
