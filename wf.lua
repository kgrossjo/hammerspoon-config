
function wfShowWindowChooser()
    wlist = hs.window.orderedWindows()
    wtable = {}
    for i = 1, #wlist do
        local w = wlist[i]
        wtable[i] = {
            ["text"] = w:title(),
            ["id"] = w:id(),
        }
    end
    wchoose = hs.chooser.new(wfSelect)
    wchoose:choices(wtable)
    wchoose:show()
end

function wfSelect(w)
    local window = hs.window.find(w.id)
    window:focus()
end

hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'return', wfShowWindowChooser)