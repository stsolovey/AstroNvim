---@type LazySpec
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = {
      ensure_installed = {
        "lua_ls",
        "gopls",
        "clangd",
        "cmake",

        -- Python:
        "pyright", -- Python LSP
      },
    },
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = {
      ensure_installed = {
        "stylua",
        "gofumpt", -- Go formatter
        "goimports", -- Go imports formatter
        "golangci-lint", -- Go linter
        "clang-format", -- C/C++ formatter
        "cpplint", -- C++ linter
        -- add more arguments for adding more null-ls sources

        -- Python:
        "black", -- Python formatter
        "isort", -- Python import formatter
        "ruff", -- Python linter
        "mypy", -- Python static type checker
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = {
      ensure_installed = {
        "python",
        "delve", -- Go debugger
        "codelldb", -- C/C++ debugger
        -- add more arguments for adding more debuggers
      },
    },
  },
}
