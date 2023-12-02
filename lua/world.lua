local sti = require('libs.sti')
local pLib = require('lua.physics')

--Collectables
require('lua.collectables')

local world = {
    map = sti('res/map/SpawnPoint.lua'),

    walls = {},

    collectables = {},

    --Count Variable / TEMPORARY :)
    sugar_count = 0,
    milk_count = 0,
    wall_count = 0,

    FPS = 0
}

function world:spawnCollectables()
    if world.map.layers["CollectableArea"] and world.map.layers["CollectableArea"].objects then
        for _, obj in pairs(world.map.layers["CollectableArea"].objects) do
            local probability = love.math.random(4)
            if probability < 3 then
                local item = New_collectables(obj.x, obj.y, probability)
                item:load()
                table.insert(self.collectables, item)
                if probability==1 then self.sugar_count = self.sugar_count + 1
                elseif probability==2 then self.milk_count = self.milk_count + 1 end
            end
        end
    end
end

function world:spawnWalls()
    if world.map.layers["cWalls"] and world.map.layers["cWalls"].objects then
        for _, obj in pairs(world.map.layers["cWalls"].objects) do
            local points = {}
            for j = 1, #obj.polygon do
                table.insert(points, obj.polygon[j].x)
                table.insert(points, obj.polygon[j].y)
            end
            local wall = pLib.newPolygonCollider(points)

            wall:setType('static')
            table.insert(self.walls, wall)
        end
    end
end

function world:load()
    self:spawnWalls()
    self:spawnCollectables()
end

function world:update()
    self.FPS = love.timer.getFPS()
end

function world:drawCollectables(camera, cursor, UI)
    for _, obj in pairs(self.collectables) do
        love.graphics.setColor({ 1, 1, 1, 1 })
        obj:draw(camera, cursor, pLib, UI)
    end
end

function world:draw(UI, camera, cursor)
    self.map:drawLayer(self.map.layers["Ground"])
    self.map:drawLayer(self.map.layers["Grasses"])
    self.map:drawLayer(self.map.layers["Fences"])
    self.map:drawLayer(self.map.layers["House"])

    self:drawCollectables(camera, cursor, UI)
end

return world
