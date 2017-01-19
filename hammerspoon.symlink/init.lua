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
   { key='b', mod={}, char='left'},
   { key='n', mod={}, char='down'},
   { key='p', mod={}, char='up'},
   { key='f', mod={}, char='right'},
   { key='a', mod={'cmd'}, char='left'},
   { key='e', mod={'cmd'}, char='right'},
   { key='w', mod={'alt'}, char='delete'}}

function makeHotKey(hotkey)
   local newkey = hs.hotkey.new(
      "ctrl",
      hotkey.key,
      function() doKeyStroke(hotkey) end,
      nil,
      nil)
   return newkey
end

local keys = map(makeHotKey, mappings)

for k, v in pairs(keys) do print(k, v) end


function enableHotKey(key)
   key:enable()
   return key
end

function disableHotKey(key)
   key:disable()
   return key
end

map(enableHotKey, keys)

print("keys 1")
for k, v in pairs(keys) do print(k, v) end

for k, v in pairs(mappings) do print(k, v) end

hs.window.filter.new('Emacs')
    :subscribe(hs.window.filter.windowFocused,function() map(disableHotKey, keys) end)
    :subscribe(hs.window.filter.windowUnfocused,function() map(enableHotKey, keys) end)
