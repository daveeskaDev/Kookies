local pLib = require('lua.physics')
local world = require('lua.world')
local UI = require('lua.UI')
local cursor = require('lua.cursor')

local hitbox = {
    x = 0,
    y = 0,

    width = 76,
    height = 90,

    --debugInformation
    isMouseTouchingCollectables = false,
    isTouchingCollectables = false,
    isTouchingFactory = false,

    isDrawing = false,

    changeDrawVar = function(self, key)
        if key == "tab" and UI.isDebugging then
            self.isDrawing = not self.isDrawing
        end

        if not UI.isDebugging then
            self.isDrawing = false
        end
    end,

    takeCollectables = function(self, obj, item, plr)
        if love.mouse.isDown(1) and self.isMouseTouchingCollectables then
            plr.inventory[item] = plr.inventory[item] + 1
            table.remove(world[item], Index(world[item], obj))
            if UI.isDebugging then
                print('1 "' .. item .. '" has been taken')
            end
        end
    end,

    draw = function(self)
        if self.isDrawing and UI.isDebugging then
            love.graphics.setColor({ 0.5, 0.34, 0.78, 0.86 })
            love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
        end
    end
}

function hitbox:collide(plr)
    for _, obj in pairs(world.sugars, world.milks) do
        if pLib.collideWith(self, obj) then
            self.isTouchingCollectables = true
            if pLib.collideWith(cursor, obj) then
                self.isMouseTouchingCollectables = true
                self:takeCollectables(obj, "sugars", plr)
            end
        end
    end
end

function hitbox:update(plr)
    self.isMouseTouchingCollectables = false
    self.isTouchingCollectables = false
    self.isTouchingFactory = false

    self.x = plr.x - 27
    self.y = plr.y - 25

    self:collide(plr)
end

return hitbox
