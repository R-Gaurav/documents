-- A better method to create the following file is by asking Claude, with your intended 
-- config. To change the colorscheme, comments' font style, look into lua/chadrc.lua.
vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " " -- leader = Space (same as `let mapleader = " "` in init.vim)

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"

-- ============================================================================
-- GENERAL SETTINGS (ported from init.vim)
-- Placed after `require "options"` so these win over NvChad's defaults.
-- ============================================================================

-- Essential defaults
-- `set nocompatible` is a no-op in Neovim (it is always nocompatible).
vim.cmd "filetype plugin indent on"

local opt = vim.opt

opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 2 -- Size of an indent
opt.softtabstop = 2 -- Number of spaces tabs count for while editing
opt.tabstop = 2 -- Number of spaces tabs count for
opt.autoindent = true -- Copy indent from current line when starting a new one
opt.smartindent = true -- Insert indents automatically

-- --- UI Visuals ---
opt.number = true -- Show line numbers
opt.relativenumber = true -- Show relative line numbers for easier jumping
opt.cursorline = true -- Highlight the current horizontal line
opt.cursorlineopt = "both" -- NvChad defaults this to "number" (only the line number is highlighted)
opt.cursorcolumn = true -- Highlight the current vertical column
opt.colorcolumn = "80" -- Draw a vertical ruler at 80 characters
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.signcolumn = "yes" -- Always show the signcolumn to prevent layout shifts
opt.showmatch = true -- Highlight matching brackets
opt.showmode = false -- Don't show mode (redundant if you use a statusline)

-- --- Behavior ---
opt.mouse = "a" -- Enable mouse support in all modes
opt.clipboard:append "unnamedplus" -- Use system clipboard for all yank/delete/paste
opt.ignorecase = true -- Ignore case in search patterns...
opt.smartcase = true -- ...unless search contains an uppercase letter
opt.undofile = true -- Maintain undo history between sessions
opt.scrolloff = 8 -- Keep 8 lines above/below cursor for context
opt.updatetime = 300 -- Faster completion and diagnostic display

require "autocmds"

-- ============================================================================
-- AUTO-COMMANDS (ported from init.vim)
-- ============================================================================

local augroup = vim.api.nvim_create_augroup("InitVimPort", { clear = true })
local autocmd = vim.api.nvim_create_autocmd

-- Force 2 spaces for ALL files
autocmd("FileType", {
  group = augroup,
  pattern = "*",
  command = "setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2",
})

-- Custom highlights: red 80-character ruler, and a lighter cursor line/column.
-- Applied now and re-applied whenever the colorscheme reloads, so a theme
-- switch doesn't reset them.

-- How much lighter than the editor background the cursor line/column is
-- (0 = same as background, 1 = white). Raise it for a lighter shade.
local cursor_lightness = 0.1

-- Blend a #rrggbb color toward white by `amount` (0..1)
local function lighten(hex, amount)
  local r = tonumber(hex:sub(2, 3), 16)
  local g = tonumber(hex:sub(4, 5), 16)
  local b = tonumber(hex:sub(6, 7), 16)
  local function mix(c)
    return math.floor(c + (255 - c) * amount + 0.5)
  end
  return string.format("#%02x%02x%02x", mix(r), mix(g), mix(b))
end

local function apply_custom_highlights()
  vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#d70000", ctermbg = "red" })

  -- Base the cursor line/column on the theme's background, so it stays a
  -- subtle-but-visible tint whichever NvChad theme is active.
  local normal_bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
  local base = normal_bg and string.format("#%06x", normal_bg) or "#1e222a"
  local cursor_bg = lighten(base, cursor_lightness)
  vim.api.nvim_set_hl(0, "CursorLine", { bg = cursor_bg })
  vim.api.nvim_set_hl(0, "CursorColumn", { bg = cursor_bg })
end
apply_custom_highlights()
autocmd("ColorScheme", { group = augroup, callback = apply_custom_highlights })

-- Specifically for Python (if it still resists)
-- autocmd("FileType", {
--   group = augroup,
--   pattern = "python",
--   command = "setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2",
-- })

-- Return to last edit position when opening files
autocmd("BufReadPost", {
  group = augroup,
  pattern = "*",
  callback = function()
    local line = vim.fn.line "'\""
    if line > 0 and line <= vim.fn.line "$" then
      vim.cmd 'normal! g`"'
    end
  end,
})

-- ============================================================================
-- AUTO-CLEANUP: Remove Trailing Whitespace
-- ============================================================================

-- Deletes all whitespace at the end of every line (callable as :lua TrimWhitespace())
function TrimWhitespace()
  local save = vim.fn.winsaveview()
  vim.cmd [[keeppatterns %s/\s\+$//e]]
  vim.fn.winrestview(save)
end

-- Trigger the function automatically before writing (saving) the buffer
autocmd("BufWritePre", {
  group = augroup,
  pattern = "*",
  callback = TrimWhitespace,
})

vim.schedule(function()
  require "mappings"

  -- ==========================================================================
  -- KEY MAPS (ported from init.vim)
  -- Defined after `require "mappings"` so they override NvChad's versions.
  -- ==========================================================================
  local map = vim.keymap.set

  -- Clear search highlighting with Escape
  map("n", "<Esc>", ":noh<CR><Esc>")

  -- Easier window navigation (Ctrl + h,j,k,l)
  map("n", "<C-h>", "<C-w>h")
  map("n", "<C-j>", "<C-w>j")
  map("n", "<C-k>", "<C-w>k")
  map("n", "<C-l>", "<C-w>l")
end)
