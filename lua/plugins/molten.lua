return {
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",   -- use version <2.0.0 to avoid breaking changes
    build = ":UpdateRemotePlugins",
    init = function()
      -- this is an example, not a default. Please see the readme for more configuration options
      vim.g.python3_host_prog=vim.fn.expand(".venv/bin/python3")
      vim.g.molten_output_win_max_height = 12
    end,
  },
  {
    "GCBallesteros/jupytext.nvim",
    config = true,
  }
}
