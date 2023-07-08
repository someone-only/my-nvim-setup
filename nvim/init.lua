require("base")
require("highlights")
require("maps")
require("plugins")

local has = function(x)
  return vim.fn.has(x) == 1
end

local is_mac = "macunix"
local is_win = "win32"

if is_mac then
  require("macos")
end

if is_win then
  require("windows")
end

vim.opt.termguicolors = true
