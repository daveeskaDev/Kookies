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
        if not self.isDebugging then self.isDevMode = false end
    end,

    load = function(self, plr, wrld, cursor, camera)
        self.debugItem:load(plr, cursor, wrld, camera)
    end,

    update = function(self, plr)
        self.debugItem:update(plr)
    end,

    draw = function(self, plr, world, cam)

        if self.isDevMode then plr.hitbox:drawBoxes(world, cam) end
        plr.inventory:draw()

        if self.isDebugging then
            self.debugItem:draw()
        end
    end
}

return UI
