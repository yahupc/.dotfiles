local overrides = require("custom.configs.overrides")
---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- Database
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      "tpope/vim-dadbod",
      "kristijanhusak/vim-dadbod-completion",
      "tpope/vim-dotenv",
    },
    event = "VeryLazy",
    config = function()
      require "custom.configs.database"
    end,
    keys = { { "<leader><leader>db", ":tab DBUI<cr>", desc = "Open Database client" } },
  },
  -- Completition
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-git",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind-nvim",
      { "L3MON4D3/LuaSnip", version = "v1.*" },
      "windwp/nvim-autopairs",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    event = "VeryLazy",
    config = function()
      require "custom.completition"
    end,
  },
  -- {
  --   "anuvyklack/pretty-fold.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require ("custom.pretty-fold").setup()
  --   end
  -- }
  --


  -- Folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    event = "VeryLazy",
    config = function()
      require "custom.ufo"
    end,
  },
  --   -- packer
  -- {
  --   "kevinhwang91/nvim-ufo",
  --   requires = {
  --     "kevinhwang91/promise-async",
  --     {
  --       "luukvbaal/statuscol.nvim",
  --       config = function()
  --         local builtin = require("statuscol.builtin")
  --         require("statuscol").setup(
  --           {
  --             relculright = true,
  --             segments = {
  --               {text = {builtin.foldfunc}, click = "v:lua.ScFa"},
  --               {text = {"%s"}, click = "v:lua.ScSa"},
  --               {text = {builtin.lnumfunc, " "}, click = "v:lua.ScLa"}
  --             }
  --           }
  --         )
  --       end
  --     }
  --   }
  -- }
  --
  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}
return plugins
