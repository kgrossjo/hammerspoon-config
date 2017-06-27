wm = hs.hotkey.modal.new('ctrl-alt-cmd', 'space')
wmtext = [[
Window Manager
h/l - left/right half
g/n - narrow/wide center
o/p - large left/right
m/c - maximized/centered
a/b - left/right no resize
s   - next screen
r   - reload
x   - console
]]
wmp = {
    alert = nil,
}

function wm:entered()
    if wmp.alert then
        hs.alert.closeSpecific(wmp.alert)
    end
    wmp.alert = hs.alert.show(wmtext, {textFont = "Menlo"}, true)
end
function wm:exited()
    if wmp.alert then
        hs.alert.closeSpecific(wmp.alert)
    end
    wmp.alert = nil
end

wm:bind('', 'h', 
    function() 
        local w = hs.window.focusedWindow()
        w:moveToUnit(hs.layout.left50)
        wm:exit()
    end
)

wm:bind('', 'l',
    function()
        local w = hs.window.focusedWindow()
        w:moveToUnit(hs.layout.right50)
        wm:exit()
    end
)

wm:bind('', 'g',
    function()
        local w = hs.window.focusedWindow()
        w:moveToUnit('[25,0 50x100]')
        wm:exit()
    end
)

wm:bind('', 'n',
    function()
        local w = hs.window.focusedWindow()
        w:moveToUnit('[15,0 70x100]')
        wm:exit()
    end
)

wm:bind('', 'm',
    function()
        local w = hs.window.focusedWindow()
        w:maximize()
        wm:exit()
    end
)

wm:bind('', 'o', 
    function ()
        local w = hs.window.focusedWindow()
        w:moveToUnit('[0,0 85x100]')
        wm:exit()
    end
)

wm:bind('', 'p',
    function ()
        local w = hs.window.focusedWindow()
        w:moveToUnit('[15,0 85x100]')
        wm:exit()
    end
)

wm:bind('', 'c',
    function ()
        local w = hs.window.focusedWindow()
        w:moveToUnit('[25,20 50x50]')
        wm:exit()
    end
)

wm:bind('', 'a', 
    function ()
        local w = hs.window.focusedWindow()
        if not w then
            hs.alert.show("No focused window")
            wm:exit()
            return
        end
        local s = w:screen()
        if not s then
            hs.alert.show("No screen?!?")
            wm:exit()
            return
        end
        local newx = s:frame().x
        local newy = w:frame().y
        w:setTopLeft(hs.geometry(newx, newy))
        wm:exit()
    end
)

wm:bind('', 'b',
    function ()
        local w = hs.window.focusedWindow()
        if not w then
            hs.alert.show("No focused window")
            wm:exit()
            return
        end
        local s = w:screen()
        if not s then
            hs.alert.show("No screen?!?")
            wm:exit()
            return
        end
        local newx = s:frame().x + s:frame().w - w:frame().w
        local newy = w:frame().y
        w:setTopLeft(hs.geometry(newx, newy))
        wm:exit()
    end
)

wm:bind('', 's',
    function ()
        local w = hs.window.focusedWindow()
        local s = w:screen()
        local ss = hs.screen.allScreens()
        local mainScreenIdx, i
        for i = 1, #ss do
            if ss[i]:id() == s:id() then
                mainScreenIdx = i
            end
        end
        local nextScreenIdx = mainScreenIdx + 1
        if nextScreenIdx > #ss then
            nextScreenIdx = 1
        end
        w:moveToScreen(ss[nextScreenIdx], false, true)
        wm:exit()
    end
)

wm:bind('', 'r',
	function()
	    hs.alert.show("Reloading...")
	    hs.reload()
	end
)

wm:bind('', 'x',
    function()
        hs.openConsole()
        wm:exit()
    end
)

wm:bind('', 'escape',
    function()
        wm:exit()
    end
)
