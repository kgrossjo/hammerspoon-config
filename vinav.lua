-- vinav.lua

-- config
vinavCmdThreshold = 0.3
-- end config

vinavCmdTime = 0
vinavPreviousFlags = nil
vinavNormalMode = false
vinavModal = hs.hotkey.modal.new()
vinavGModal = hs.hotkey.modal.new()
vinavVisual = false
vinavAlert = nil
vinavCount = nil
vinavCountAlert = nil

function vinavEvent(event)
    evTime = hs.timer.secondsSinceEpoch()
    typ = event:getType()
    if typ == hs.eventtap.event.types.flagsChanged then
        flags = event:getFlags()
        if vinavIsCmdOnly(flags) and vinavIsNoFlag(vinavPreviousFlags) then
            vinavCmdTime = evTime
        elseif vinavIsNoFlag(flags) and vinavIsCmdOnly(vinavPreviousFlags) then
            if evTime - vinavCmdTime < vinavCmdThreshold and evTime - vinavCmdTime > 0.001 then
                vinavToggleNormalMode()
            end
            vinavCmdTime = 0
        else
            vinavCmdTime = 0
        end
        vinavPreviousFlags = flags
    else
        vinavCmdTime = 0
    end
end

function vinavIsCmdOnly(flags)
    if not flags then
        return false
    elseif not flags.cmd then 
        return false
    elseif flags.alt or flags.shift or flags.ctrl then
        return false
    else
        return true
    end
end

function vinavIsNoFlag(flags)
    if not flags then
        return false
    elseif flags.cmd or flags.alt or flags.shift or flags.ctrl then
        return false
    else
        return true
    end
end

function vinavEnterNormalMode()
    vinavAlert = hs.alert.show("Normal mode", true)
    vinavVisual = false
    vinavModal:enter()
end

function vinavExitNormalMode()
    vinavModal:exit()
    hs.alert.closeSpecific(vinavAlert)
end

function vinavEnterGMode()
   hs.alert.closeSpecific(vinavAlert)
   vinavAlert = hs.alert.show("Normal mode: g", true)
   vinavGModal:enter()
end

function vinavExitGMode()
   vinavGModal:exit()
   hs.alert.closeSpecific(vinavAlert)
end

function vinavToggleNormalMode()
    vinavNormalMode = not vinavNormalMode
    if vinavNormalMode then
        vinavEnterNormalMode()
    else
        vinavExitNormalMode()
    end
end

function vinavModifiers(mods)
    if vinavVisual then
        if mods then
            return 'shift-' .. mods
        else
            return 'shift'
        end
    else
        if mods then
            return mods
        else
            return ''
        end
    end
end

function vinavGetCount()
    result = ( vinavCount or 1 )
    vinavCount = nil
    if vinavCountAlert then
        hs.alert.closeSpecific(vinavCountAlert)
    end
    return result
end

function vinavDown()
    for i=1, vinavGetCount(), 1 do
        hs.eventtap.keyStroke(vinavModifiers(), 'down')
    end
end

function vinavUp()
    for i=1, vinavGetCount(), 1 do
        hs.eventtap.keyStroke(vinavModifiers(), 'up')
    end
end

function vinavLeft()
    for i=1, vinavGetCount(), 1 do
        hs.eventtap.keyStroke(vinavModifiers(), 'left')
    end
end

function vinavRight()
    for i=1, vinavGetCount(), 1 do
        hs.eventtap.keyStroke(vinavModifiers(), 'right')
    end
end

function vinavWordLeft()
    for i=1, vinavGetCount(), 1 do
        hs.eventtap.keyStroke(vinavModifiers('alt'), 'left')
    end
end

function vinavWordRight()
    for i=1, vinavGetCount(), 1 do
        hs.eventtap.keyStroke(vinavModifiers('alt'), 'right')
    end
end

function vinavBeginningOfLine()
   hs.eventtap.keyStroke(vinavModifiers('cmd'), 'left')
end

function vinavEndOfLine()
   hs.eventtap.keyStroke(vinavModifiers('cmd'), 'right')
end

function vinavAppend()
    hs.eventtap.keyStroke(vinavModifiers(), 'right')
    vinavExitNormalMode()
end

function vinavAppendEndOfLine()
    hs.eventtap.keyStroke(vinavModifiers('cmd'), 'right')
    vinavExitNormalMode()
end

function vinavTop()
    hs.eventtap.keyStroke(vinavModifiers('cmd'), 'up')
end

function vinavBottom()
    hs.eventtap.keyStroke(vinavModifiers('cmd'), 'down')
end

function vinavVisual()
    vinavVisual = not vinavVisual
    if vinavVisual then
        hs.alert.show("visual mode")
    end
end

function vinavCut()
    hs.eventtap.keyStroke('cmd', 'x')
    vinavVisual = false
end

function vinavCopy()
    hs.eventtap.keyStroke('cmd', 'c')
    vinavVisual = false
end

function vinavPaste()
    hs.eventtap.keyStroke('cmd', 'v')
    vinavVisual = false
end

function vinavUndo()
    hs.eventtap.keyStroke('cmd', 'z')
    vinavVisual = false
end

function vinavDelete()
    hs.eventtap.keyStroke('', 'forwarddelete')
    vinavVisual = false
end

function vinavAppendLine()
    hs.eventtap.keyStroke('cmd', 'right')
    hs.eventtap.keyStroke('', 'return')
    vinavVisual = false
end

function vinavInsertLine()
    hs.eventtap.keyStroke('', 'up')
    hs.eventtap.keyStroke('cmd', 'right')
    hs.eventtap.keyStroke('', 'return')
    vinavVisual = false
end

function vinavReturn()
    hs.eventtap.keyStroke('', 'return')
    vinavExitNormalMode()
end

function vinavIncrement(i)
    vinavCount = ( vinavCount or 0 )
    if vinavCount < 100 then
	vinavCount = vinavCount * 10
	vinavCount = vinavCount + i
    end
    if vinavCountAlert then
        hs.alert.closeSpecific(vinavCountAlert)
    end
    vinavCountAlert = hs.alert.show("Count: " .. tostring(vinavCount), true)
end

vinavModal:bind('', 'j', vinavDown)
vinavModal:bind('', 'k', vinavUp)
vinavModal:bind('', 'h', vinavLeft)
vinavModal:bind('', 'delete', vinavLeft)
vinavModal:bind('', 'l', vinavRight)
vinavModal:bind('', 'space', vinavRight)
vinavModal:bind('', 'g', vinavEnterGMode)
vinavModal:bind('shift', 'g', vinavBottom)
vinavModal:bind('', 'v', vinavVisual)
vinavModal:bind('', 'i', vinavExitNormalMode)
vinavModal:bind('', 'escape', vinavExitNormalMode)
vinavModal:bind('shift', '6', vinavBeginningOfLine)
vinavModal:bind('shift', '4', vinavEndOfLine)
vinavModal:bind('', 'a', vinavAppend)
vinavModal:bind('shift', 'a', vinavAppendEndOfLine)
vinavModal:bind('', 'd', vinavCut)
vinavModal:bind('', 'y', vinavCopy)
vinavModal:bind('', 'p', vinavPaste)
vinavModal:bind('', 'u', vinavUndo)
vinavModal:bind('', 'x', vinavDelete)
vinavModal:bind('', 'b', vinavWordLeft)
vinavModal:bind('', 'w', vinavWordRight)
vinavModal:bind('', 'o', vinavAppendLine)
vinavModal:bind('shift', 'o', vinavInsertLine)
vinavModal:bind('', 'return', vinavReturn)
vinavModal:bind('', '0', function () vinavIncrement(0) end)
vinavModal:bind('', '1', function () vinavIncrement(1) end)
vinavModal:bind('', '2', function () vinavIncrement(2) end)
vinavModal:bind('', '3', function () vinavIncrement(3) end)
vinavModal:bind('', '4', function () vinavIncrement(4) end)
vinavModal:bind('', '5', function () vinavIncrement(5) end)
vinavModal:bind('', '6', function () vinavIncrement(6) end)
vinavModal:bind('', '7', function () vinavIncrement(7) end)
vinavModal:bind('', '8', function () vinavIncrement(8) end)
vinavModal:bind('', '9', function () vinavIncrement(9) end)

vinavGModal:bind('', 'h',
		 function ()
		     vinavBeginningOfLine()
		     vinavExitGMode()
		 end
)
vinavGModal:bind('', 'l',
		 function ()
		     vinavEndOfLine()
		     vinavExitGMode()
		 end
)
vinavGModal:bind('', 'g',
		 function ()
		     vinavTop()
		     vinavExitGMode()
		 end
)

vinav = hs.eventtap.new({
    hs.eventtap.event.types.flagsChanged,
    hs.eventtap.event.types.keyDown,
    hs.eventtap.event.types.keyUp}, vinavEvent)
vinav:start()
