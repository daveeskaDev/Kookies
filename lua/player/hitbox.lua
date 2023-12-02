local hitbox = {
    x = 0,
    y = 0,

    width = 76,
    height = 90,

    --debugInformation
    isTouchingCollectables = false,
    isTouchingFactory = false,

    draw = function(self, UI)
        if UI.isDevMode then
            love.graphics.setColor({ 0.5, 0.34, 0.78, 0.86 })
            love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
        end
    end
}

function hitbox:collide(plr, world, pLib, cursor, camera)
    for i, obj in pairs(world.collectables) do
        if pLib.collideWith(self, obj) then
            self.isTouchingCollectables = true
        end
        local box = {
            x = obj.x,
            y = obj.y,
            width = obj.width * camera.scale,
            height = obj.height * camera.scale
        }
        box.x, box.y = camera:cameraCoords(obj.x, obj.y)
        if pLib.collideWith(cursor, box) then
            cursor.isTouchingCollectables = true
            if self.isTouchingCollectables then
                cursor.mode=2
                if love.mouse.isDown(1) then
                    table.insert(plr.inventory.items, obj)
                    table.remove(world.collectables, i)
                end
            end
        end
    end
end

function hitbox:drawBoxes(world, camera)
    for _, obj in pairs(world.collectables) do
        local box = {
            x = obj.x,
            y = obj.y,
            width = obj.width * camera.scale,
            height = obj.height * camera.scale
        }
        box.x, box.y = camera:cameraCoords(obj.x, obj.y)
        love.graphics.setColor(0.1, 0.3, 0)
        love.graphics.rectangle("fill", box.x, box.y, box.width, box.height)
    end
end

function hitbox:update(plr, world, pLib, cursor, camera)
    self.isTouchingCollectables = false
    self.isTouchingFactory = false

    self.x = plr.x - 27
    self.y = plr.y - 25

    self:collide(plr, world, pLib, cursor, camera)
end

return hitbox
