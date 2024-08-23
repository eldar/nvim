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

require("lsp_signature").setup()
