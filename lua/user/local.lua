--local _, _ = pcall(vim.cmd, "set background=light")
local _, _ = pcall(vim.cmd, "colorscheme morning")
vim.opt.relativenumber = false

--require('lualine').setup({ options = { theme = "auto" } })

--lualine setup
local lualine_theme = {
  command = {
    a = {
      bg = "#ffffff",
      fg = "#d4d4d4",
      gui = "bold"
    }
  },
  inactive = {
    a = {
      bg = "#ffffff",
      fg = "#d4d4d4"
    },
    b = {
      bg = "#ffffff",
      fg = "#d4d4d4"
    },
    c = {
      bg = "#ffffff",
      fg = "#d4d4d4"
    }
  },
  insert = {
    a = {
      bg = "#ffffff",
      fg = "#d4d4d4",
      gui = "bold"
    }
  },
  normal = {
    a = {
      bg = "#ffffff",
      fg = "#d4d4d4",
      gui = "bold"
    },
    b = {
      bg = "#ffffff",
      fg = "#d4d4d4"
    },
    c = {
      bg = "#ffffff",
      fg = "#d4d4d4"
    }
  },
  replace = {
    a = {
      bg = "#ffffff",
      fg = "#d4d4d4",
      gui = "bold"
    }
  },
  visual = {
    a = {
      bg = "#ffffff",
      fg = "#d4d4d4",
      gui = "bold"
    }
  }
}

local lualine_cfg = require("lualine").get_config()
--print(vim.inspect(lualine_cfg))
lualine_cfg.options.theme = lualine_theme
--now apply the setup
require("lualine").setup(lualine_cfg)
