require('mason').setup({})

local lsp_zero = require('lsp-zero')
lsp_zero.extend_lspconfig()
lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
end)

local neoconf = require("neoconf")
neoconf.setup({})

local lspconfig = require("lspconfig")

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local function settings(server, default)
  return neoconf.get("lspconfig." .. server, default or {}, { lsp = true })
end

require('mason-lspconfig').setup({
    ensure_installed = { "lua_ls", "rust_analyzer", "basedpyright", "clangd" },
    handlers = {
        lsp_zero.default_setup,
        -- pylsp = function()
        --     lspconfig.pylsp.setup({
        --       cmd = { "pylsp" },
        --       filetypes = { "python" },
        --       settings = {
        --           pylsp = {
        --               configurationSources = {"flake8"},
        --               flake8 = {enabled = true},
        --               pycodestyle = {enabled = false},
        --           },
        --       }
        --     })
        -- end,
       basedpyright = function()
          lspconfig.basedpyright.setup({
            -- settings = settings("basedpyright"),
            settings = {
              basedpyright = {
                analysis = {
                  useLibraryCodeForTypes = true,
                  typeCheckingMode = "basic", -- off, basic, standard, strict, all
                  diagnosticSeverityOverrides = {
                    reportDuplicateImport = "warning",
                  },
                  logLevel = "Trace",
                  -- diagnosticSeverityOverrides = {
                  --   -- https://github.com/detachhead/basedpyright/blob/main/docs/configuration.md
                  --   reportUndefinedVariable = "error",
                  --   reportUnusedVariable = "warning",
                  --   reportUnknownParameterType = false,
                  --   reportUnknownArgumentType = false,
                  --   reportUnknownLambdaType = false,
                  --   reportUnknownVariableType = true,
                  --   reportUnknownMemberType = false,
                  --   reportMissingParameterType = false,
                  --   reportPossiblyUnboundVariable = "info",
                  -- },
                },
              },
            },
            capabilities = capabilities,
            root_dir = require("lspconfig.util").root_pattern(
              "pyproject.toml",
              ".git"
            ),
          })
        end,
       -- pyright = function()
       --    lspconfig.pyright.setup({
       --      settings = settings("pyright"),
       --      capabilities = capabilities,
       --      root_dir = require("lspconfig.util").root_pattern(
       --        "pyproject.toml",
       --        ".git"
       --      ),
       --    })
       --  end,
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            lspconfig.lua_ls.setup(lua_opts)
        end,
        rust_analyzer = lsp_zero.noop, -- Exclude rust_analyze from autoconfiguration, required by rustaceanvim
    },
})

local cmp = require("cmp")

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = {
    { name = "nvim_lsp" },
    -- { name = "nvim_lsp_signature_help" },
  },
})

-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

local lspkind = require('lspkind')
cmp.setup {
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                     -- can also be a function to dynamically calculate max width such as 
                     -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      show_labelDetails = true, -- show labelDetails in menu. Disabled by default

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      -- before = function (entry, vim_item)
      --   ...
      --   return vim_item
      -- end
    })
  }
}
require("lsp_signature").setup()
