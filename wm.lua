wm = hs.hotkey.modal.new('alt', 'space')
wmtext = [[
Window Manager
h/l     - left/right half
g/n     - narrow/wide center
o/p     - large left/right
m/c/t/T - max/ctr/terminal/chat
a/b     - left/right no resize
1/2/3/4 - top l/r, bottom
s/B/S   - next scr. / bluet. / sleep
r/x     - reload / console
spc/ret - iTerm / finder
]]
wmp = {
    alert = nil,
}
bluetooth = require("hs._asm.undocumented.bluetooth")


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

wm:bind('', '.',
    function()
        local w = hs.window.focusedWindow()
        w:minimize()
        wm:exit()
    end
)

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

wm:bind('', '1',
    function()
        local w = hs.window.focusedWindow()
        w:moveToUnit('[0,0 50x50]')
        wm:exit()
    end
)

wm:bind('', '2',
    function()
        local w = hs.window.focusedWindow()
        w:moveToUnit('[50,0 50x50]')
        wm:exit()
    end
)

wm:bind('', '3',
    function()
        local w = hs.window.focusedWindow()
        w:moveToUnit('[0,50 50x50]')
        wm:exit()
    end
)

wm:bind('', '4',
    function()
        local w = hs.window.focusedWindow()
        w:moveToUnit('[50,50 50x50]')
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
wm:bind('', 't',
	function()
		local w = hs.window.focusedWindow()
        w:moveToUnit('[0,0 40x70]')
        wm:exit()
	end
)
wm:bind('shift', 't',
    function()
        local w = hs.window.focusedWindow()
        w:moveToUnit('[0,30 45x70]')
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

wm:bind('shift', 'n',
    function()
        local w = hs.window.focusedWindow()
        w:moveToUnit('[10,0 80x100]')
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
        w:moveToUnit('[0,0 80x100]')
        wm:exit()
    end
)

wm:bind('shift', 'o',
function ()
    local w = hs.window.focusedWindow()
    w:moveToUnit('[30,0 70x100]')
    wm:exit()
end
)

wm:bind('ctrl', 'o',
    function ()
        local w = hs.window.focusedWindow()
        w:moveToUnit('[0,0 85x85]')
        wm:exit()
    end
)

wm:bind('', 'p',
    function ()
        local w = hs.window.focusedWindow()
        w:moveToUnit('[20,0 80x100]')
        wm:exit()
    end
)

wm:bind('shift', 'p',
    function ()
        local w = hs.window.focusedWindow()
        w:moveToUnit('[30,0 70x100]')
        wm:exit()
    end
)

wm:bind('ctrl', 'p',
    function ()
        local w = hs.window.focusedWindow()
        w:moveToUnit('[30,0 85x85]')
        wm:exit()
    end
)

wm:bind('', 'c',
    function ()
        local w = hs.window.focusedWindow()
        w:moveToUnit('[15,10 70x70]')
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

wm:bind('shift', 'b',
    function ()
        local b = bluetooth.power()
        if b then
            hs.alert.show("Turning Bluetooth off")
        else
            hs.alert.show("Turning Bluetooth on")
        end
        bluetooth.power(not b)
        wm:exit()
    end
)

wm:bind('shift', 's',
    function ()
        hs.caffeinate.systemSleep()
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

wm:bind('', 'return',
    function()
        hs.application.open('Finder')
        wm:exit()
    end
)

wm:bind('', 'space',
    function()
        hs.application.open('iTerm')
        wm:exit()
    end
)

wm:bind('', 'w',
    function()
        hs.application.open('Safari')
        wm:exit()
    end
)

wm:bind('', 'escape',
    function()
        wm:exit()
    end
)

wm:bind('ctrl-alt-cmd', 'space',
    function()
        wm:exit()
    end
)
