return function(use)
  use({"folke/which-key.nvim"})
  use { "nvim-telescope/telescope-file-browser.nvim" },
    use {
    'kelly-lin/ranger.nvim',
    config = function()
        local ranger_nvim = require("ranger-nvim")
        ranger_nvim.setup({
        enable_cmds = false,
        replace_netrw = false,
        keybinds = {
          ["ov"] = ranger_nvim.OPEN_MODE.vsplit,
          ["oh"] = ranger_nvim.OPEN_MODE.split,
          ["ot"] = ranger_nvim.OPEN_MODE.tabedit,
          ["or"] = ranger_nvim.OPEN_MODE.rifle,
        },
      })
      end,
  }
end
