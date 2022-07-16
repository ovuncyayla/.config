local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return require('packer').startup(function(use)
  use {
    "wbthomason/packer.nvim",
    -- display = {
    --   open_fn = function()
    --     return require("packer.util").float { border = "rounded" }
    --   end,
    -- },
    -- profile = {
    --   enable = true,
    --   threshold = 0.0001,
    -- },
    -- git = {
    --   clone_timeout = 300,
    --   subcommands = {
    --     update = "pull --rebase",
    --   },
    -- },
    -- auto_clean = true,
    -- compile_on_sync = true,
  }

  -- Optimiser
  use {
    "lewis6991/impatient.nvim",
  }

  -- Lua functions
  use { "nvim-lua/plenary.nvim" }

  -- Popup API
  use {
    "nvim-lua/popup.nvim",
  }

  -- Indent detection
  use {
    "Darazaki/indent-o-matic", event = "BufReadPost",
  }

  -- Notification Enhancer
  use {
    "rcarriga/nvim-notify", event = "VimEnter",
  }

  -- Neovim UI Enhancer
  use { "MunifTanjim/nui.nvim" }

  -- Cursorhold fix
  -- use {
  --   "antoinemadec/FixCursorHold.nvim",
  --   event = { "BufRead", "BufNewFile" },
  --   config = function()
  --     vim.g.cursorhold_updatetime = 100
  --   end,
  -- }

  -- Smarter Splits
  use { "mrjones2014/smart-splits.nvim" }

  -- Icons
  use {
    "kyazdani42/nvim-web-devicons",
    event = "VimEnter",
  }

  -- Bufferline
  use {
    "akinsho/bufferline.nvim",
    after = "nvim-web-devicons",
  }

  -- Better buffer closing
  use { "famiu/bufdelete.nvim", cmd = { "Bdelete", "Bwipeout" } }

  -- File explorer
  use { "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    -- cmd = "Neotree",
    requires = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    setup = function()
      vim.g.neo_tree_remove_legacy_commands = true
    end,
  }

  -- Statusline
  use { "feline-nvim/feline.nvim", after = "nvim-web-devicons" }

  -- Parenthesis highlighting
  use { "p00f/nvim-ts-rainbow", after = "nvim-treesitter" }

  -- Autoclose tags
  use { "windwp/nvim-ts-autotag", after = "nvim-treesitter" }

  -- Context based commenting
  use { "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" }

  -- Syntax highlighting
  use { "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    event = { "BufRead", "BufNewFile" },
    cmd = {
      "TSInstall",
      "TSInstallInfo",
      "TSInstallSync",
      "TSUninstall",
      "TSUpdate",
      "TSUpdateSync",
      "TSDisableAll",
      "TSEnableAll",
    }
  }

  -- Snippet collection
  use { "rafamadriz/friendly-snippets" }

  -- Snippet engine
  use { "L3MON4D3/LuaSnip", as = "luasnip", after = "friendly-snippets" }

  -- Completion engine
  use { "hrsh7th/nvim-cmp", event = "InsertEnter" }

  -- Snippet completion source
  use { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" }

  -- Buffer completion source
  use { "hrsh7th/cmp-buffer", after = "nvim-cmp", }

  -- Path completion source
  use { "hrsh7th/cmp-path", after = "nvim-cmp" }

  -- LSP completion source
  use { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" }

  -- Built-in LSP
  use { "neovim/nvim-lspconfig", event = "VimEnter" }

  -- LSP manager
  use { "williamboman/nvim-lsp-installer", after = "nvim-lspconfig" }

  -- LSP symbols
  use { "stevearc/aerial.nvim" }

  -- Formatting and linting
  use { "jose-elias-alvarez/null-ls.nvim", event = { "BufRead", "BufNewFile" } }

  -- Fuzzy finder
  use { "nvim-telescope/telescope.nvim", requires ="nvim-lua/plenary.nvim" } 

  -- Fuzzy finder syntax support
  use { ("nvim-telescope/telescope-%s-native.nvim"):format(vim.fn.has "win32" == 1 and "fzy" or "fzf"),
    after = "telescope.nvim",
    run = vim.fn.has "win32" ~= 1 and "make" or nil,
    config = function()
      require("telescope").load_extension(vim.fn.has "win32" == 1 and "fzy_native" or "fzf")
    end,
  }

  -- Git integration
  use { "lewis6991/gitsigns.nvim", event = "BufEnter" }

  -- Start screen
  use { "goolord/alpha-nvim", cmd = "Alpha" }

  -- Color highlighting
  use { "norcalli/nvim-colorizer.lua", event = { "BufRead", "BufNewFile" } }

  -- Autopairs
  use { "windwp/nvim-autopairs", event = "InsertEnter" }

  -- Terminal
  use { "akinsho/nvim-toggleterm.lua" }

  -- Commenting
  use { "numToStr/Comment.nvim" }

  -- Indentation
  use { "lukas-reineke/indent-blankline.nvim", event = "BufRead" }

  -- Keymaps popup
  use { "folke/which-key.nvim" }

  -- Smooth scrolling
  -- use { "declancm/cinnamon.nvim",
  --   event = { "BufRead", "BufNewFile" },
  --   config = function()
  --     --      require "configs.cinnamon"
  --   end,
  -- }

  -- Smooth escaping
  use { "max397574/better-escape.nvim", event = "InsertCharPre" }

  -- Get extra JSON schemas
  use { "b0o/SchemaStore.nvim", module = "schemastore" }

  -- Session manager
  use { "Shatur/neovim-session-manager",
    module = "session_manager",
    cmd = "SessionManager",
    event = "BufWritePost",
    config = function()
      --      require "configs.session_manager"
    end,
  }
  use { "ur4ltz/surround.nvim",
    event = "BufRead",
    config = function()
      require("surround").setup { mappings_style = "surround" }
    end,
  }
  use { "phaazon/hop.nvim",
    branch = "v1", -- optional but strongly recommended
    event = "BufRead", -- I want to use it all the time
    config = function()
      require("hop").setup()
    end,
  }
  use { "beauwilliams/focus.nvim",
    event = "BufRead",
    config = function()
      require("focus").setup {
        excluded_filetypes = { "toggleterm", "TelescopePrompt" },
        cursorline = false,
        signcolumn = false,
      }
    end,
  }
  use { "ray-x/lsp_signature.nvim", event = "InsertEnter", }
  use { "KabbAmine/vCoolor.vim",
    cmd = "VCoolor",
  }
  use { "mfussenegger/nvim-dap",
    module = "dap",
    --    config = require "user.plugins.nvim-dap",
  }
  use { "rcarriga/nvim-dap-ui",
    after = "nvim-dap",
    --    config = require "user.plugins.nvim-dapui",
  }
  use { "sindrets/winshift.nvim",
    cmd = "WinShift",
    --    config = require "user.plugins.WinShift",
  }
  use { "nvim-telescope/telescope-file-browser.nvim" }
  use { "nvim-telescope/telescope-dap.nvim" }
  use { "nvim-telescope/telescope-packer.nvim" }
  use { "nvim-telescope/telescope-project.nvim" }
  use { "cljoly/telescope-repo.nvim" }
  use { "aserowy/tmux.nvim" }
  use { "nvim-treesitter/playground",
    cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
  }
  use {
    "theHamsta/nvim-dap-virtual-text",
    after = "nvim-dap",
  }
  use { "ziontee113/syntax-tree-surfer", module = "syntax-tree-surfer" }
  use { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" }
  use { "andymass/vim-matchup",
    event = "BufRead",
    config = function()
      vim.g.matchup_matchparen_offscreen = {}
    end,
  }
  use { "hrsh7th/cmp-nvim-lua", after = "cmp_luasnip" }
  use { "SmiteshP/nvim-gps", event = "BufRead", }
  use { "jvgrootveld/telescope-zoxide",
    module = "telescope._extensions.zoxide",
  }
  use { "nvim-neorg/neorg",
    ft = "norg",
    after = "nvim-treesitter",
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},
          ["core.norg.dirman"] = {
            config = {
              workspaces = {
                work = "~/notes/work",
                personal = "~/notes/personal",
              },
            },
          },
          ["core.integrations.telescope"] = {},
        },
      }
      local neorg_callbacks = require "neorg.callbacks"

      neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
        -- Map all the below keybinds only when the "norg" mode is active
        keybinds.map_event_to_mode("norg", {
          n = { -- Bind keys in normal mode
            { "<C-s>", "core.integrations.telescope.find_linkable" },
          },

          i = { -- Bind in insert mode
            { "<C-l>", "core.integrations.telescope.insert_link" },
          },
        }, {
          silent = true,
          noremap = true,
        })
      end)
    end,
    requires = "nvim-neorg/neorg-telescope",
  }
  use { "LunarVim/darkplus.nvim", }
  use { "catppuccin/nvim", as = "catppuccin" }
  use { 'frenzyexists/aquarium-vim', }
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
