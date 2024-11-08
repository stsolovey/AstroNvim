-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {
  {
    "leoluz/nvim-dap-go",
    dependencies = { "mfussenegger/nvim-dap" },
    ft = "go",
    config = function(_, opts)
      require("dap-go").setup(opts)
    end,
  },
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      -- Основные настройки
      go = "go", -- путь к go binary
      goimports = "gopls", -- использовать gopls для импортов
      fillstruct = "gopls", -- использовать gopls для заполнения структур
      gofmt = "gofumpt", -- использовать gofumpt для форматирования
      max_line_len = 120, -- максимальная длина строки
      tag_transform = false, -- использовать snake_case в json тегах
      test_template = "", -- шаблон для тестов
      test_template_dir = "", -- директория с шаблонами тестов
      comment_placeholder = "   ", -- плейсхолдер для комментариев
      -- Настройки icons (если установлен Nerd Font)
      icons = {
        breakpoint = "🔴",
        currentpos = "🔷",
      },
      -- Настройки для тестирования
      test_runner = "go",
      run_in_floaterm = false, -- запускать тесты в floating terminal
      -- Настройки линтера
      linter = "golangci-lint",
      linter_flags = "",
      lint_prompt_style = "vt", -- стиль вывода ошибок линтера
      -- Настройки отладчика
      dap_debug = true,
      dap_debug_gui = true,
      dap_debug_keymap = true, -- использовать стандартные кеймаппинги для отладки
      -- Настройки для gopls
      gopls_cmd = nil, -- использовать gopls из PATH
      gopls_remote_auto = true,
      gocoverage_sign = "█",
      sign_priority = 5,
      -- Настройки для тегов
      tags_name = "json", -- имя тега по умолчанию
      tags_options = { "json=omitempty" }, -- опции для тегов
      tags_transform = "snakecase", -- трансформация имен в тегах
      tags_flags = { "-transform", "snakecase" },
      -- Настройки для функций
      trouble = false, -- интеграция с trouble.nvim
      test_efm = false, -- использовать efm-langserver
      luasnip = true,
      -- Настройки для mock генерации
      mock_timeout = 10000,
      mock_version = "",
    },
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
  }
}

