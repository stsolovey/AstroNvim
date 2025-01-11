-- In lua/plugins/avante.lua
return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = "*",
  build = "make",
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-tree/nvim-web-devicons",
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          use_absolute_path = true,
          drag_and_drop = { insert_mode = true },
        },
      },
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  opts = function()
    local opts = {
      provider = "openai",
      auto_suggestions_provider = "openai",
      openai = {
        endpoint = "https://api.deepseek.com/v1",
        model = "deepseek-coder",
        timeout = 30000,
        temperature = 0,
        max_tokens = 4096,
        api_key_name = "cmd:pass show deepseek-api-key",
      },
      behaviour = {
        auto_suggestions = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = true,
        minimize_diff = true,
      },
      windows = {
        position = "right",
        width = 30,
        sidebar_header = {
          enabled = true,
          align = "center",
          rounded = true,
        },
        input = {
          prefix = "> ",
          height = 8,
        },
        edit = {
          border = "rounded",
          start_insert = true,
        },
        ask = {
          floating = false,
          start_insert = true,
          border = "rounded",
          focus_on_apply = "ours",
        },
      },
    }

    -- Your custom mappings
    opts.mappings = {
      diff = {
        ours = "co",
        theirs = "ct",
        all_theirs = "ca",
        both = "cb",
        cursor = "cc",
        next = "]x",
        prev = "[x",
      },
      suggestion = {
        accept = "<M-l>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
      jump = {
        next = "]]",
        prev = "[[",
      },
      submit = {
        normal = "<CR>",
        insert = "<C-s>",
      },
    }

    return opts
  end,
  config = function(_, opts)
    -- Set required vim options
    vim.opt.laststatus = 3
    vim.opt.updatetime = 100
    vim.opt.timeoutlen = 300

    -- Load avante_lib before setup
    require("avante_lib").load()
    require("avante").setup(opts)
  end,
  keys = function(_, keys)
    -- Get plugin opts
    local opts =
      require("lazy.core.plugin").values(require("lazy.core.config").spec.plugins["avante.nvim"], "opts", false)

    -- Define mappings
    local mappings = {
      {
        "<leader>aa",
        function() require("avante.api").ask() end,
        desc = "avante: ask",
        mode = { "n", "v" },
      },
      {
        "<leader>ar",
        function() require("avante.api").refresh() end,
        desc = "avante: refresh",
        mode = { "n", "v" },
      },
      {
        "<leader>ae",
        function() require("avante.api").edit() end,
        desc = "avante: edit",
        mode = { "n", "v" },
      },
    }

    -- Filter out empty mappings
    mappings = vim.tbl_filter(function(m) return m[1] and #m[1] > 0 end, mappings)

    return vim.list_extend(mappings, keys)
  end,
}
