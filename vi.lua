vi = hs.hotkey.modal.new('alt', 'space')
vip = {
    selectMode = false
}

function vi:entered()
    vip.viAlert = hs.alert.show("vi", true)
end
function vi:exited()
    if vip.viAlert then
        hs.alert.closeSpecific(vip.viAlert)
    end
    vip.viAlert = nil
end
function vi:getModifiers()
    if vip.selectMode then
        return 'shift'
    else
        return ''
    end
end
function vi:escape()
    vi.visualOff()
    vi:exit()
end
function vi:visual()
    vip.selectMode = not vip.selectMode
    if vip.visualAlert then
        hs.alert.closeSpecific(vip.visualAlert)
        vip.visualAlert = nil
    end
    if vip.selectMode then
        vip.visualAlert = hs.alert.show('Visual', true)
    end
end
function vi:visualOn()
    vip.selectMode = false
    vi.visual()
end
function vi:visualOff()
    vip.selectMode = true
    vi.visual()
end
function vi:left()
    hs.eventtap.keyStroke(vi.getModifiers(), 'left')
end
function vi:right()
    hs.eventtap.keyStroke(vi.getModifiers(), 'right')
end
function vi:down()
    hs.eventtap.keyStroke(vi.getModifiers(), 'down')
end
function vi:up()
    hs.eventtap.keyStroke(vi.getModifiers(), 'up')
end
function vi:yank()
    vi.visualOff()
    hs.eventtap.keyStroke('cmd', 'c')
end
function vi:delete()
    vi.visualOff()
    hs.eventtap.keyStroke('cmd', 'x')
end
function vi:put()
    vi.visualOff()
    hs.eventtap.keyStroke('cmd', 'v')
end
function vi:undo()
    vip.selectMode = false
    hs.eventtap.keyStroke('cmd', 'z')
end

vi:bind('', 'escape', function() vi.escape() end)
vi:bind('alt', 'space', function() vi.escape() end)
vi:bind('', 'i', function() vi.escape() end)
vi:bind('', 'j', function() vi.down() end)
vi:bind('', 'k', function() vi.up() end)
vi:bind('', 'h', function() vi.left() end)
vi:bind('', 'l', function() vi.right() end)
vi:bind('', 'v', function() vi.visual() end)
vi:bind('', 'y', function() vi.yank() end)
vi:bind('', 'd', function() vi.delete() end)
vi:bind('', 'p', function() vi.put() end)
vi:bind('', 'u', function() vi.undo() end)
