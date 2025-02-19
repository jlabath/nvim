--local _, _ = pcall(vim.cmd, "set background=light")
local _, _ = pcall(function() vim.cmd "colorscheme tokyonight-day" end)
vim.opt.relativenumber = false
--whichwrap line wrapping
vim.cmd "set whichwrap=b,s"

--read in background color
local sl_hl = vim.api.nvim_get_hl_by_name("StatusLine", true)
local sl_bg_hex = string.format("#%06x", sl_hl.background) -- convert the background to hex

--- lualine setup start
--local gray = "#32363e"
--local dark_gray = "#282C34"

--local line_bg = "#ffffff"
--this does not quite work yet TODO
local line_bg = sl_bg_hex
local red = "#D16969"
local blue = "#569CD6"
local green = "#6A9955"
local cyan = "#4EC9B0"
local orange = "#CE9178"
local indent = "#CE9178"
--local yellow = "#DCDCAA"
local yellow_orange = "#D7BA7D"
local purple = "#C586C0"


--lualine setup
local lualine_theme = {
  command = {
    a = {
      bg = line_bg,
      fg = "#d4d4d4",
      gui = "bold"
    }
  },
  inactive = {
    a = {
      bg = line_bg,
      fg = "#d4d4d4"
    },
    b = {
      bg = line_bg,
      fg = "#d4d4d4"
    },
    c = {
      bg = line_bg,
      fg = "#d4d4d4"
    }
  },
  insert = {
    a = {
      bg = line_bg,
      fg = "#d4d4d4",
      gui = "bold"
    }
  },
  normal = {
    a = {
      bg = line_bg,
      fg = "#d4d4d4",
      gui = "bold"
    },
    b = {
      bg = line_bg,
      fg = "#d4d4d4"
    },
    c = {
      bg = line_bg,
      fg = "#d4d4d4"
    }
  },
  replace = {
    a = {
      bg = line_bg,
      fg = "#d4d4d4",
      gui = "bold"
    }
  },
  visual = {
    a = {
      bg = line_bg,
      fg = "#d4d4d4",
      gui = "bold"
    }
  }
}

local lualine_cfg = require("lualine").get_config()
local icons = require "user.icons"
--print(vim.inspect(lualine_cfg))
lualine_cfg.options.theme = lualine_theme
--tweak other things about lualine

local left_pad = {
  function()
    return " ["
  end,
  padding = 0,
  color = function()
    return { fg = blue, bg = line_bg }
  end,
}

local right_pad = {
  function()
    return "] "
  end,
  padding = 0,
  color = function()
    return { fg = blue, bg = line_bg }
  end,
}

--table for mode colors
local mode_color = {
  n = blue,
  i = orange,
  v = "#b668cd",
  [""] = "#b668cd",
  V = "#b668cd",
  -- c = '#B5CEA8',
  -- c = '#D7BA7D',
  c = "#46a6b2",
  no = "#D16D9E",
  s = green,
  S = orange,
  [""] = orange,
  ic = red,
  R = "#D16D9E",
  Rv = red,
  cv = blue,
  ce = blue,
  r = red,
  rm = "#46a6b2",
  ["r?"] = "#46a6b2",
  ["!"] = "#46a6b2",
  t = red,
}


local get_mode = require('lualine.utils.mode').get_mode

local mode = {
  -- mode component
  function()
    -- return "▊"
    -- return " "
    -- return "  "
    return string.lower(get_mode()) .. " "
  end,
  color = function()
    return { fg = mode_color[vim.fn.mode()], bg = line_bg }
  end,
  padding = 0,
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "%#SLGitIcon#" .. " " .. "%*" .. "%#SLBranchName#",
  -- color = "Constant",
  colored = false,
  padding = 0,
  -- cond = hide_in_width_100,
  fmt = function(str)
    if str == "" or str == nil then
      return "!=vcs"
    end

    return str
  end,
  --color = { fg = blue, bg = line_bg },
}


lualine_cfg.sections.lualine_a = { left_pad, mode, branch, right_pad }

local left_pad_alt = {
  function()
    return " "
  end,
  padding = 0,
  color = function()
    return { fg = blue, bg = line_bg }
  end,
}

local right_pad_alt = {
  function()
    return " "
  end,
  padding = 0,
  color = function()
    return { fg = blue, bg = line_bg }
  end,
}

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = {
    error = "%#SLError#" .. icons.diagnostics.Error .. "%*" .. " ",
    warn = "%#SLWarning#" .. icons.diagnostics.Warning .. "%*" .. " ",
  },
  colored = false,
  update_in_insert = false,
  always_visible = true,
  padding = 0,
}


lualine_cfg.sections.lualine_b = { left_pad_alt, diagnostics, right_pad_alt }


vim.api.nvim_set_hl(0, "SLGitIcon", { fg = "#E8AB53", bg = line_bg })
vim.api.nvim_set_hl(0, "SLTermIcon", { fg = purple, bg = line_bg })
vim.api.nvim_set_hl(0, "SLBranchName", { fg = "#abb2bf", bg = line_bg, bold = false })
vim.api.nvim_set_hl(0, "SLFileName", { fg = yellow_orange, bg = line_bg })
vim.api.nvim_set_hl(0, "SLProgress", { fg = purple, bg = line_bg })
vim.api.nvim_set_hl(0, "SLLocation", { fg = blue, bg = line_bg })
vim.api.nvim_set_hl(0, "SLFT", { fg = cyan, bg = line_bg })
vim.api.nvim_set_hl(0, "SLIndent", { fg = indent, bg = line_bg })
vim.api.nvim_set_hl(0, "SLLSP", { fg = "#6b727f", bg = "NONE" })
vim.api.nvim_set_hl(0, "SLSep", { fg = line_bg, bg = sl_bg_hex })
vim.api.nvim_set_hl(0, "SLFG", { fg = "#abb2bf", bg = "NONE" })
vim.api.nvim_set_hl(0, "SLSeparator", { fg = "#6b727f", bg = sl_bg_hex, italic = true })
vim.api.nvim_set_hl(0, "SLError", { fg = "#bf616a", bg = sl_bg_hex })
vim.api.nvim_set_hl(0, "SLWarning", { fg = yellow_orange, bg = sl_bg_hex })


--now apply the setup
require("lualine").setup(lualine_cfg)
--- lualine setup end

--formatting shenanigans
--here we deny the ones that are true outright
local denylist = {
  someweirdserver = true,
  --clangd = true,
  --jsonls = true,
  --tsserver = true,
  --stylelint_lsp = true,
}

local denylist_by_filetype = {
  -- lua = {
  --   sumneko_lua = true,
  -- },
  -- markdown = {
  --   html = true,
  -- },
  rust = {
    null_ls = true,
  }
}

--if this function returns true we allow the client for formatting
local function get_filter(bufnr)
  return function(client)
    if denylist[client.name] then
      return false
    end

    local filetype = vim.api.nvim_buf_get_option(bufnr or 0, "filetype")
    local denylist_for_filetype = denylist_by_filetype[filetype]
    if not denylist_for_filetype or true then
      return true
    end

    return not denylist_for_filetype[client.name]
  end
end

local function simple_save()
  -- --get current bufnr
  -- local bufnr = vim.api.nvim_get_current_buf()
  -- --format
  -- vim.lsp.buf.format {
  --   filter = get_filter(bufnr),
  --   bufnr = bufnr
  -- }
  --save
  vim.cmd "noa w"
end

vim.keymap.set('n', '<F2>', simple_save)

--lsp restart that maybe used to restart broekn lsp servers e.g. elm
--this however does not make cargo check happen even if it does restart rust-analyzer
local function lsp_restart()
  --save
  vim.cmd "noa w"
  --request stop of all lsp clients
  vim.lsp.stop_client(vim.lsp.get_active_clients())
  for _, client in pairs(vim.lsp.get_active_clients()) do
    --end time
    local stop_at = os.clock() + 1
    while stop_at > os.clock() do
      if client.is_stopped() then
        break
      end
    end
    --final check of client plus force shutdown
    if not client.is_stopped() then
      client.stop(true)
    end
    --more waiting for client to go away
    stop_at = os.clock() + 1
    while stop_at > os.clock() do
      if client.is_stopped() then
        break
      end
    end
    --consider logging here if that darn thing is still alive at this point
  end
  --force reload which will start LSP and therefore check
  vim.cmd "edit"
end

vim.keymap.set('n', '<F3>', lsp_restart)
