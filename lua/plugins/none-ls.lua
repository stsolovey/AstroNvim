return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    local null_ls = require "null-ls"
    opts.sources = require("astrocore").list_insert_unique(opts.sources, {
      -- Linter
      null_ls.builtins.diagnostics.golangci_lint.with {
        diagnostic_config = {
          underline = true,
          virtual_text = true,
          signs = true,
          update_in_insert = false,
          severity_sort = true,
        },
      },
      -- Formatters
      null_ls.builtins.formatting.gofumpt,
      null_ls.builtins.formatting.goimports,
    })
  end,
}

-- return {
--   "nvimtools/none-ls.nvim",
--   opts = function(_, opts)
--     local null_ls = require "null-ls"
--     opts.sources = require("astrocore").list_insert_unique(opts.sources, {
--       -- Linter with optimizations
--       null_ls.builtins.diagnostics.golangci_lint.with({
--         diagnostics_format = "[#{c}] #{m} (#{s})",
--         args = function(params)
--           return {
--             "run",
--             "--out-format=json",
--             "--path-prefix", params.root,
--             "--config=" .. params.root .. "/.golangci.yml",  -- Explicitly point to config
--             params.filename
--           }
--         end,
--         debounce = 1000,
--         runtime_condition = function(params)
--           return params.event == "BufWritePost"
--         end,
--       }),
--       -- Formatters
--       null_ls.builtins.formatting.gofumpt,
--       null_ls.builtins.formatting.goimports,
--     })
--   end,
-- }
