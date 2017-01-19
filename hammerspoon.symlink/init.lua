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
