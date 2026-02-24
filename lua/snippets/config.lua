local ls_fmt = require("luasnip.extras.fmt").fmt
local collection = require("luasnip.session.snippet_collection")

local ls = require "luasnip"
local ls_snippet = ls.snippet
local ls_insert_node = ls.insert_node

---@class Snippets
local Snippets = {}

---@param filetype string
---@param snippet LuaSnip.Addable[]|{[string]: LuaSnip.Addable[]}
---@return nil
function Snippets.new(filetype, snippet)
    -- Clear snippets
    collection.clear_snippets(filetype)

    ls.add_snippets(filetype, snippet)
end

-- Rewrite of LuaSnip functions
Snippets.fmt = ls_fmt
Snippets.name = ls_snippet

---@class Position
local Position = {
    N = 0,
    M = 1,
    I = 2,
}

---@param pos string
---@return nil
function Snippets.mode(pos)
    local value = Position[pos]
    ls_insert_node(value)
end

return Snippets
