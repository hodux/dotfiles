require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls" }
vim.lsp.enable(servers)

-- add nixd
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

vim.lsp.config("nixd", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    nixd = {
      nixpkgs = {
        expr = "import <nixpkgs> { }",
      },
      formatting = {
        command = { "nixfmt" },
      },
      options = {
        nixos = {
            expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.default.options',
        },
      },
    },
  },
})

vim.lsp.enable("nixd")

-- read :h vim.lsp.config for changing options of lsp servers 
