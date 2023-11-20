local UI = {
    debugItem = require('lua.UI.debugItem'),
    isDebugging = false,
    isDevMode = false,

    guiItem = require('lua.UI.GUIItem'),

    --Functions
    activateDebug = function(self, key)
        if key == "f3" then
            self.isDebugging = not self.isDebugging
        end
        if self.isDebugging and key == "tab" then
            self.isDevMode = not self.isDevMode
        end
    end,

    load = function(self, plr, wrld, cursor)
        self.debugItem:load(plr, cursor, wrld)
    end,

    update = function(self)
        self.debugItem:update()
    end,

    draw = function(self)
        if self.isDebugging then
            self.debugItem:draw()
        end
    end
}

return UI
