wfFilter = hs.window.filter.new()

function wfShowWindowChooser()
    wlist = wfFilter:getWindows()
    wtable = {}
    for i = 1, #wlist do
        local w = wlist[i]
        wtable[i] = {
            ["text"] = w:title(),
            ["id"] = w:id(),
        }
    end
    local cur = hs.window.focusedWindow()
    wchoose = hs.chooser.new(function (w) wfSelect(w, cur) end)
    wchoose:choices(wtable)
    wchoose:show()
end

function wfSelect(w, fallback)
    if not w then
        fallback:focus()
    else
        local window = hs.window.find(w.id)
        window:focus()
    end
end

hs.hotkey.bind({'cmd', 'alt'}, 'return', wfShowWindowChooser)