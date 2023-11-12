local pLib = require('lua.physics')
local world = require('lua.world')
local UI = require('lua.UI')

local hitbox = {
    x=0,
    y=0,

    width=23,
    height=40,

    --debugInformation
    isTouchingCollectables=false,
    isTouchingFactory=false,
    isDrawing=false,


    changeDrawVar = function(self, key)
        if key=="tab" and UI.isDebugging then
            self.isDrawing = not self.isDrawing
        end
    end,

    collide = function(self)
        for _,obj in pairs(world.sugars or world.milks) do
            if pLib.collideWith(self, obj) then
                self.isTouchingCollectables = true
            end
        end
    end,

    takeCollectables=function(self, key)
        if self.
    end,

    draw = function(self)
        if self.isDrawing and UI.isDebugging then
            love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
        end
    end
}

function hitbox:update(plr)
    self.x=plr.x
    self.y=plr.y

    self:collide()
end

return hitbox
