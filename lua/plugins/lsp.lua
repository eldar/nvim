return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            -- "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp"
        },
    },
    {
        "ray-x/lsp_signature.nvim",
    },
    { "folke/neoconf.nvim" },
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x"
    },
    {
        "williamboman/mason.nvim",
    },
    {
        "williamboman/mason-lspconfig.nvim",
    },
    {
        "neovim/nvim-lspconfig",
    },
    {
      'linrongbin16/lsp-progress.nvim',
      config = function()
        require('lsp-progress').setup()
      end
    },
    {
      "hedyhli/outline.nvim",
      lazy = true,
      cmd = { "Outline", "OutlineOpen" },
      keys = { -- Example mapping to toggle outline
        { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
        { "<leader>fo", "<cmd>OutlineFocus<CR>", desc = "Toggle outline" },
      },
      opts = {
        -- Your setup opts here
      },
    },
}
