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
      imports = {
        goimports = true, -- Use goimports
        gofmt = true, -- Use gofmt
      },
      tag_transform = false, -- использовать snake_case в json тегах
      test_template = "", -- шаблон для тестов
      test_template_dir = "", -- директория с шаблонами тестов
      comment_placeholder = "   ", -- плейсхолдер для комментариев
      -- Настройки для тестирования
      test_runner = "go",
      run_in_floaterm = false, -- запускать тесты в floating terminal
      test_efm = false,
      test_timeout = "30s", -- timeout for tests
      test_env = { -- environment variables for tests
        GO_TEST_PARALLEL = "8", -- enable parallel testing
      },
      verbose_tests = true, -- enable verbose test output
      -- Coverage settings
      coverage_handler = function(data)
        -- Store last coverage file
        vim.g.last_coverage_file = data.coverprofile

        -- Add signs for coverage
        require("go.coverage").show()

        -- Generate and store HTML report
        local html_file = vim.fn.expand "%:p:h" .. "/coverage.html"
        vim.fn.system("go tool cover -html=" .. data.coverprofile .. " -o " .. html_file)
        vim.g.last_coverage_html = html_file
      end,
      coverage_sign = "│", -- or "█" if you prefer block
      coverage_sign_priority = 10,
      -- Custom commands
      commands = {
        coverage_clear = function()
          -- Clear signs
          vim.fn.sign_unplace "GoCoverage"
          -- Clear highlighting
          vim.cmd "highlight clear GoCoverageCovered"
          vim.cmd "highlight clear GoCoverageUncovered"
          -- Remove temporary files
          if vim.g.last_coverage_file then
            vim.fn.delete(vim.g.last_coverage_file)
            vim.g.last_coverage_file = nil
          end
          if vim.g.last_coverage_html then
            vim.fn.delete(vim.g.last_coverage_html)
            vim.g.last_coverage_html = nil
          end
        end,
        coverage_browser = function()
          if vim.g.last_coverage_html then
            -- For Linux
            vim.fn.system("xdg-open " .. vim.g.last_coverage_html)
          -- For macOS (uncomment if needed)
          -- vim.fn.system('open ' .. vim.g.last_coverage_html)
          else
            vim.notify("No coverage report available. Run coverage first.", vim.log.levels.WARN)
          end
        end,
      },
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
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- Making sure it loads only when needed
    lazy = true,
    config = function()
      -- LazyGit configuration options
      vim.g.lazygit_floating_window_winblend = 0
      vim.g.lazygit_floating_window_scaling_factor = 0.9
      vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
      vim.g.lazygit_floating_window_use_plenary = 0
      vim.g.lazygit_use_neovim_remote = 1

      -- Load telescope extension
      require("telescope").load_extension "lazygit"
    end,
    keys = {
      { "<leader>gg", "<cmd>LazyGit<CR>", desc = "LazyGit" },
      {
        "<leader>gG",
        function() require("telescope").extensions.lazygit.lazygit() end,
        desc = "LazyGit Repository Selector",
      },
    },
  },
  -- Toggle Explorer Settings (hidden filedirs visibility)
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
    },
  },

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
