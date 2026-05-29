-- Enable faster startup by caching compiled Lua modules
vim.loader.enable()

-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Globals
_G.Util = require("util")

-- Load config
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("plugins")
