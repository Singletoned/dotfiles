function string:split(sSeparator, nMax, bRegexp)
    assert(sSeparator ~= '')
    assert(nMax == nil or nMax >= 1)

    local aRecord = {}

    if self:len() > 0 then
        local bPlain = not bRegexp
        nMax = nMax or -1

        local nField, nStart = 1, 1
        local nFirst,nLast = self:find(sSeparator, nStart, bPlain)
        while nFirst and nMax ~= 0 do
            aRecord[nField] = self:sub(nStart, nFirst-1)
            nField = nField+1
            nStart = nLast+1
            nFirst,nLast = self:find(sSeparator, nStart, bPlain)
            nMax = nMax-1
        end
        aRecord[nField] = self:sub(nStart)
    end

    return aRecord
end

local doKeyStroke = function(hotkey)
  local event = require("hs.eventtap").event
  event.newKeyEvent(hotkey.mod, string.lower(hotkey.char), true):post()
  event.newKeyEvent(hotkey.mod, string.lower(hotkey.char), false):post()
end

function map(func, tbl)
   local newtbl = {}
   for i,v in pairs(tbl) do
      newtbl[i] = func(v)
   end
   return newtbl
end

local mappings = {
   { key='ctrl+b', mod={}, char='left'},
   { key='ctrl+n', mod={}, char='down'},
   { key='ctrl+p', mod={}, char='up'},
   { key='ctrl+f', mod={}, char='right'},
   { key='ctrl+a', mod={'cmd'}, char='left'},
   { key='ctrl+e', mod={'cmd'}, char='right'},
   { key='ctrl+w', mod={'alt'}, char='delete'}}

function makeHotKey(hotkey)
   pair = string.split(hotkey.key, "+")
   local newkey = hs.hotkey.new(
      pair[1],
      pair[2],
      function() doKeyStroke(hotkey) end,
      nil,
      nil)
   return newkey
end

local keys = map(makeHotKey, mappings)

function enableHotKey(key)
   key:enable()
   return key
end

function disableHotKey(key)
   key:disable()
   return key
end

map(enableHotKey, keys)

hs.window.filter.new('Emacs')
    :subscribe(hs.window.filter.windowFocused,function() map(disableHotKey, keys) end)
    :subscribe(hs.window.filter.windowUnfocused,function() map(enableHotKey, keys) end)
