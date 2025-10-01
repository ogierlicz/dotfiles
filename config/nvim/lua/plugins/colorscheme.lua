return {
  -- add gruvbox
  {
    "wittyjudge/gruvbox-material.nvim",
    lazy = false,
    priority = 1000,
  },
  -- add gruvdark
  {
    "darianmorat/gruvdark.nvim",
    lazy = false,
    priority = 1000,
  },
  -- add bamboo
  {
    "ribru17/bamboo.nvim",
    lazy = false,
    priority = 1000,
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvdark",
    },
  },
}
