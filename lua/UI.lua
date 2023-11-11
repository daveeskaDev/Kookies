local UI={
    debugItem=require('lua.UI.debugItem'),
    isDebugging=false,

    --Functions
    activateDebug = function(self, key)
        if key=="f3" then
            self.isDebugging = not self.isDebugging
        end
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
