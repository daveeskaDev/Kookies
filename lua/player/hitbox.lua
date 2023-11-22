local hitbox = {
    x = 0,
    y = 0,

    width = 76,
    height = 90,

    --debugInformation
    isTouchingCollectables = false,
    isTouchingFactory = false,

    takeCollectables = function(self, obj, item, plr, world, UI)
        if love.mouse.isDown(1) and self.isMouseTouchingCollectables then
            plr.inventory[item] = plr.inventory[item] + 1
            table.remove(world[item], Index(world[item], obj))
            if UI.isDebugging then
                print('1 "' .. item .. '" has been taken')
            end
        end
    end,

    draw = function(self, UI)
        if UI.isDevMode then
            love.graphics.setColor({ 0.5, 0.34, 0.78, 0.86 })
            love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
        end
    end
}

function hitbox:collide(plr, world, UI, pLib, cursor)
    for i,obj in pairs(world.sugars, world.milks) do
        if pLib.collideWith(self, obj) then
            self.isTouchingCollectables=true
        end

        if pLib.collideWith(cursor, obj) then
            cursor.isTouchingCollectables = true
            if love.mouse.isDown(1) and self.isTouchingCollectables then
                table.remove(world[i], obj)
            end
        end
    end
end

function hitbox:update(plr, world, UI, pLib, cursor)
    self.isTouchingCollectables = false
    self.isTouchingFactory = false

    self.x = plr.x - 27
    self.y = plr.y - 25

    self:collide(plr, world, UI, pLib, cursor)
end

return hitbox
