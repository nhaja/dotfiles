hs.hotkey.bind("cmd", "q", function() end)
hs.hotkey.bind("cmd", "j", function() end)
hs.hotkey.bind("cmd", "k", function() end)
hs.hotkey.bind("cmd", "l", function() end)

hs.hotkey.bind("option", "h", function()
    hs.eventtap.keyStroke({}, "left")
end)

hs.hotkey.bind("option", "j", function()
    hs.eventtap.keyStroke({}, "down")
end)

hs.hotkey.bind("option", "k", function()
    hs.eventtap.keyStroke({}, "up")
end)

hs.hotkey.bind("option", "l", function()
    hs.eventtap.keyStroke({}, "right")
end)
