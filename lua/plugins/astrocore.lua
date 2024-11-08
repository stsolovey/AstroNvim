-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

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

               -- Создаем подменю для Go команд под клавишей <leader>g
        ["<leader>g"] = { desc = "Go Tools" },
        
        -- Тесты
        ["<leader>gt"] = { desc = "Go Tests" },
        ["<leader>gtt"] = { "<cmd>GoTest<cr>", desc = "Run Tests" },
        ["<leader>gtf"] = { "<cmd>GoTestFunc<cr>", desc = "Test Function" },
        ["<leader>gtF"] = { "<cmd>GoTestFile<cr>", desc = "Test File" },
        ["<leader>gtc"] = { "<cmd>GoCoverage<cr>", desc = "Test Coverage" },
        
        -- Инструменты разработки
        ["<leader>gi"] = { desc = "Go Implementation" },
        ["<leader>gii"] = { "<cmd>GoImpl<cr>", desc = "Implement Interface" },
        ["<leader>gif"] = { "<cmd>GoFillStruct<cr>", desc = "Fill Struct" },
        ["<leader>gip"] = { "<cmd>GoFixPlurals<cr>", desc = "Fix Plurals" },
        
        -- Управление тегами
        ["<leader>ga"] = { desc = "Go Tags" },
        ["<leader>gaa"] = { "<cmd>GoAddTag<cr>", desc = "Add Tags" },
        ["<leader>gar"] = { "<cmd>GoRmTag<cr>", desc = "Remove Tags" },
        
        -- Генерация кода
        ["<leader>gc"] = { desc = "Go Generate" },
        ["<leader>gcm"] = { "<cmd>GoMockGen<cr>", desc = "Generate Mock" },
        ["<leader>gcc"] = { "<cmd>GoCmt<cr>", desc = "Generate Comment" },
        
        -- Управление модулями
        ["<leader>gm"] = { desc = "Go Modules" },
        ["<leader>gmt"] = { "<cmd>GoModTidy<cr>", desc = "Go Mod Tidy" },
        ["<leader>gmg"] = { "<cmd>GoGet<cr>", desc = "Go Get" },
        
        -- Обновление инструментов
        ["<leader>gu"] = { desc = "Go Update" },
        ["<leader>gui"] = { "<cmd>GoInstallBinaries<cr>", desc = "Install Binaries" },
        ["<leader>guu"] = { "<cmd>GoUpdateBinaries<cr>", desc = "Update Binaries" },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
      },
    },
  },
}
