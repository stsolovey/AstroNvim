---@type LazySpec
return {
  -- Go debugging
  {
    "leoluz/nvim-dap-go",
    dependencies = { "mfussenegger/nvim-dap" },
    ft = "go",
    config = function(_, opts) require("dap-go").setup(opts) end,
  },
  -- Go development plugin
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
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
      -- Настройки icons (если установлен Nerd Font)
      -- icons = {
      --   breakpoint = "🔴",
      --   currentpos = "🔷",
      -- },
    },
  },
  -- gRPC tools
  {
    "hudclark/grpc-nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  -- PlantUML support
  {
    "https://gitlab.com/itaranto/plantuml.nvim",
    version = "*",
    config = function() require("plantuml").setup() end,
  },
  -- YANG syntax support
  { "nathanalderson/yang.vim" },
  -- Database tools
  { "tpope/vim-dadbod" },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql", "clickhouse" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Основные настройки DBUI
      vim.g.db_ui_use_nerd_fonts = 1
      -- Предустановленные соединения
      vim.g.db_ui_save_location = vim.fn.stdpath "config" .. "/db_ui"
      -- Примеры соединений для разных БД
      vim.g.dbs = {
        -- ClickHouse соединение
        {
          name = "ClickHouse Local",
          url = "clickhouse://default:@localhost:9000/default",
        },
      }
    end,
  },
  -- Git integration
  { "tpope/vim-fugitive" },
  -- Python virtual environment selector
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
      name = {
        "venv",
        ".venv",
        ".env",
        "env",
      },
      search = true,
    },
    cmd = "VenvSelect",
  },
  -- Python debugging
  {
    "mfussenegger/nvim-dap-python",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local dap_python = require "dap-python"
      dap_python.setup "~/.virtualenvs/debugpy/bin/python"
      dap_python.test_runner = "pytest"
    end,
    ft = "python",
  },
}
