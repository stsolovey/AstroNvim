---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
        mouse = "a", -- enable mouse in all modes
        -- tabstop = 4, -- number of spaces a tab counts for
        -- shiftwidth = 4, -- number of spaces to use for autoindent
        -- softtabstop = 4, -- number of spaces a tab counts for while editing
        -- expandtab = true, -- convert tabs to spaces
        -- autoindent = true, -- copy indent from current line when starting new line
        -- smartindent = true, -- do smart autoindenting when starting a new line
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        -- --------------------------------- Main Testing Menu ----------------------------------
        -- --------------------------------- ================= ----------------------------------
        -- ["<leader>T"] = { desc = "Testing" },
        --
        -- -- Quick Test Actions
        -- ["<leader>TT"] = { "<cmd>GoTest<cr>", desc = "Test Package" },
        -- ["<leader>Tf"] = { "<cmd>GoTestFunc<cr>", desc = "Test Function" },
        -- ["<leader>TF"] = { "<cmd>GoTestFile<cr>", desc = "Test File" },
        -- ["<leader>Ta"] = { "<cmd>GoTestAll<cr>", desc = "Test All" },
        --
        -- -- Test Configuration
        -- ["<leader>Ts"] = { desc = "Settings" },
        -- ["<leader>Tsp"] = {
        --   function()
        --     local count = vim.fn.input "Number of parallel tests: "
        --     vim.env.GO_TEST_PARALLEL = count
        --     vim.notify("Parallel tests set to: " .. count)
        --   end,
        --   desc = "Set Parallel Count",
        -- },
        -- ["<leader>Tsv"] = {
        --   function()
        --     vim.g.go_test_verbose = not vim.g.go_test_verbose
        --     vim.notify("Verbose testing: " .. (vim.g.go_test_verbose and "enabled" or "disabled"))
        --   end,
        --   desc = "Toggle Verbose",
        -- },
        -- ["<leader>Tst"] = {
        --   function()
        --     local timeout = vim.fn.input "Test timeout (e.g., 30s, 1m): "
        --     vim.g.go_test_timeout = timeout
        --     vim.notify("Test timeout set to: " .. timeout)
        --   end,
        --   desc = "Set Timeout",
        -- },
        --
        -- -- Coverage commands
        -- ["<leader>Tc"] = { desc = "Coverage" },
        -- ["<leader>Tct"] = { "<cmd>GoCoverage<cr>", desc = "Toggle Coverage" },
        -- ["<leader>Tcc"] = { function() require("go").commands.coverage_clear() end, desc = "Clear Coverage" },
        -- ["<leader>Tcb"] = { function() require("go").commands.coverage_browser() end, desc = "Open in Browser" },
        -- ["<leader>Tcs"] = { "<cmd>GoTestSum<cr>", desc = "Coverage Summary" },
        --
        -- -- Test Output/Results
        -- ["<leader>To"] = { desc = "Output" },
        -- ["<leader>Tos"] = { "<cmd>GoTestSum<cr>", desc = "Summary" },
        -- ["<leader>Tov"] = { "<cmd>GoVet<cr>", desc = "Go Vet" },
        -- --------------------------------------------------------------------
        -- --------------------------------------------------------------------
        ------------------ GO TOOLS ----------------------------------------
        ------------------==========----------------------------------------
        -- Создаем подменю для Go команд под клавишей <leader>G
        ["<leader>G"] = { desc = "Go Tools" },

        -- Тесты
        ["<leader>Gt"] = { desc = "Go Tests" },
        ["<leader>Gtt"] = { "<cmd>GoTest<cr>", desc = "Run Tests" },
        ["<leader>Gtf"] = { "<cmd>GoTestFunc<cr>", desc = "Test Function" },
        ["<leader>GtF"] = { "<cmd>GoTestFile<cr>", desc = "Test File" },
        ["<leader>Gtc"] = { "<cmd>GoCoverage<cr>", desc = "Test Coverage" },

        -- Инструменты разработки
        ["<leader>Gi"] = { desc = "Go Implementation" },
        ["<leader>Gii"] = { "<cmd>GoImpl<cr>", desc = "Implement Interface" },
        ["<leader>Gif"] = { "<cmd>GoFillStruct<cr>", desc = "Fill Struct" },
        ["<leader>Gip"] = { "<cmd>GoFixPlurals<cr>", desc = "Fix Plurals" },

        -- Управление тегами
        ["<leader>Ga"] = { desc = "Go Tags" },
        ["<leader>Gaa"] = { "<cmd>GoAddTag<cr>", desc = "Add Tags" },
        ["<leader>Gar"] = { "<cmd>GoRmTag<cr>", desc = "Remove Tags" },

        -- Генерация кода:
        ["<leader>Gc"] = { desc = "Go Generate" },
        ["<leader>Gcm"] = { "<cmd>GoMockGen<cr>", desc = "Generate Mock" },
        ["<leader>Gcc"] = { "<cmd>GoCmt<cr>", desc = "Generate Comment" },

        -- Управление модулями
        ["<leader>Gm"] = { desc = "Go Modules" },
        ["<leader>Gmt"] = { "<cmd>GoModTidy<cr>", desc = "Go Mod Tidy" },
        ["<leader>Gmg"] = { "<cmd>GoGet<cr>", desc = "Go Get" },

        -- Обновление инструментов
        ["<leader>Gu"] = { desc = "Go Update" },
        ["<leader>Gui"] = { "<cmd>GoInstallBinaries<cr>", desc = "Install Binaries" },
        ["<leader>Guu"] = { "<cmd>GoUpdateBinaries<cr>", desc = "Update Binaries" },
        --
        -- -- Todo comments
        -- ["<leader>ft"] = { "<cmd>TodoTelescope<cr>", desc = "Search TODOs" },
        --
        -- -- Text case
        -- ["<leader>tc"] = { desc = "Text Case" },
        -- ["<leader>tcc"] = { function() require("textcase").current_word "to_camel_case" end, desc = "camelCase" },
        -- ["<leader>tcs"] = { function() require("textcase").current_word "to_snake_case" end, desc = "snake_case" },
        -- ["<leader>tcp"] = { function() require("textcase").current_word "to_pascal_case" end, desc = "PascalCase" },
        --
        -- -- tables with just a `desc` key will be registered with which-key if it's installed
        -- -- this is useful for naming menus
        -- -- ["<Leader>b"] = { desc = "Buffers" },
        --
        -- -- setting a mapping to false will disable it
        -- -- ["<C-S>"] = false,
        -- --
        -- -- -- set up Ctrl+click for references
        -- ["<C-LeftMouse>"] = { "<LeftMouse><cmd>lua vim.lsp.buf.definition()<cr>", desc = "Go to definition" },
        -- ["<M-LeftMouse>"] = { "<LeftMouse><cmd>Telescope lsp_references<cr>", desc = "Show references" },
        --
        -- ["<leader>cl"] = {
        --   function() vim.lsp.codelens.refresh() end,
        --   desc = "Refresh CodeLens",
        -- },
        --
        -- ["<leader>L"] = { desc = "Linting" },
        -- ["<leader>Lc"] = {
        --   function()
        --     vim.diagnostic.reset()
        --     vim.diagnostic.open_float()
        --   end,
        --   desc = "Show Diagnostics",
        -- },
        -- ["<leader>Li"] = { "<cmd>NullLsInfo<cr>", desc = "Show Linter Info" },
        --
        ------------------------- Python Start --------------------------
        ---
        -- Create Python submenu
        ["<leader>p"] = { desc = "Python Tools" },

        -- Virtual Environment
        ["<leader>pv"] = { desc = "Virtual Environment" },
        ["<leader>pvs"] = { "<cmd>VenvSelect<cr>", desc = "Select Virtualenv" },
        ["<leader>pvc"] = { "<cmd>VenvSelectCached<cr>", desc = "Select Cached Virtualenv" },

        -- Testing
        ["<leader>pt"] = { desc = "Python Tests" },
        ["<leader>ptr"] = { "<cmd>Neotest run<cr>", desc = "Run nearest test" },
        ["<leader>ptf"] = { "<cmd>Neotest run file<cr>", desc = "Test File" },
        ["<leader>pts"] = { "<cmd>Neotest summary<cr>", desc = "Test Summary" },
        ["<leader>pto"] = { "<cmd>Neotest output<cr>", desc = "Test Output" },

        -- Debugging
        ["<leader>pd"] = { desc = "Debug" },
        ["<leader>pdd"] = { "<cmd>lua require('dap-python').debug_selection()<cr>", desc = "Debug Selection" },
        ["<leader>pdt"] = { "<cmd>lua require('dap-python').test_method()<cr>", desc = "Debug Method" },
        ["<leader>pdc"] = { "<cmd>lua require('dap-python').test_class()<cr>", desc = "Debug Class" },

        -- LSP actions
        ["<leader>pi"] = { desc = "Import Organization" },
        ["<leader>pii"] = { "<cmd>PyrightOrganizeImports<cr>", desc = "Organize Imports" },
        ["<leader>pir"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename Symbol" },
        ---
        ------------------------- Python End -------------------------
      },
    },
  },
}
