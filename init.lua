#
require('vi')
require('wm')
require('wf')

--[[
local hst = require('hs.tiling')

hs.hotkey.bind({'alt'}, 'j', function () hst.cycle(1) end)
hs.hotkey.bind({'alt'}, 'k', function () hst.cycle(-1) end)
hs.hotkey.bind({'alt'}, 'c', function () hst.cycleLayout() end)
hs.hotkey.bind({'alt'}, 'return', function () hst.promote() end)
hs.hotkey.bind({'alt'}, 'f', function () hst.goToLayout('fullscreen') end)
]]

hs.alert.show("Initialized")


--[[
kwindows = hs.expose.new(nil, {showThumbnails = true})
hs.hotkey.bind(
    {"cmd", 'alt', 'ctrl'}, 'return',
    function() kwindows:toggleShow() end
)
]]
