local pLib = require('lua.physics')
local world = require('lua.world')
local UI = require('lua.UI')

local hitbox = {
    x = 0,
    y = 0,

    width = 76,
    height = 90,

    --debugInformation 
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
        local point = {
            x = love.mouse.getX(),
            y = love.mouse.getY(),
            width = 1,
            height = 1
        }
        if pLib.collideWith(point, obj) then
            print(point.x, point.y, point.width, point.height)
            if love.mouse.isDown(1) then
                plr.inventory[item] = plr.inventory[item] + 1
                table.remove(world[item], Index(world[item], obj))
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
    for _, obj in pairs(world.sugars) do
        if pLib.collideWith(self, obj) then
            self.isTouchingCollectables = true
            self:takeCollectables(obj, "sugars", plr)
        end
    end

    for _, obj in pairs(world.milks) do
        if pLib.collideWith(self, obj) then
            self.isTouchingCollectables = true
            self:takeCollectables(obj, "milks", plr)
        end
    end
end

function hitbox:update(plr)
    self.x = plr.x - 27
    self.y = plr.y - 25

    self:collide(plr)
end

return hitbox
