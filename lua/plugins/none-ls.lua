return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    opts.debug = true -- включаем отладку
    local null_ls = require "null-ls"
    opts.sources = require("astrocore").list_insert_unique(opts.sources, {
      -- Linter
      null_ls.builtins.diagnostics.golangci_lint,
      -- .with {
      --   -- Убираем #{s} из формата, чтобы не показывать W: / E: в тексте
      --   diagnostics_format = "#{m}",
      -- },
      -- Formatters
      null_ls.builtins.formatting.gofumpt,
      null_ls.builtins.formatting.goimports,
    })
  end,
}
