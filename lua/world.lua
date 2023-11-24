local sti = require('libs.sti')
local pLib = require('lua.physics')

--Collectables
require('lua.collectables')

local world = {
    map = sti('res/map/SpawnPoint.lua'),

    walls = {},

    sugars = {},
    milks = {},

    --Count Variable / TEMPORARY :)
    sugar_count = 0,
    milk_count = 0,
    wall_count = 0,

    FPS=0
}

function world:spawnCollectables()
    if world.map.layers["CollectableArea"] and world.map.layers["CollectableArea"].objects then
        for _, obj in pairs(world.map.layers["CollectableArea"].objects) do
            local probability = love.math.random(4)
            if probability == 1 then
                local sugar = New_collectables(obj.x, obj.y, 1)
                sugar:load()
                table.insert(world.sugars, sugar)
            end
            if probability == 2 then
                local milk = New_collectables(obj.x, obj.y, 2)
                milk:load()
                table.insert(world.milks, milk)
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
    self.sugar_count = #self.sugars
    self.milk_count = #self.milks
    self.wall_count = #self.walls

    self.FPS = love.timer.getFPS()
end

function world:drawCollectables(camera, cursor)
    for _, obj in pairs(self.milks, self.sugars) do
        love.graphics.setColor({ 1, 1, 1, 1 })
        obj:draw(camera, cursor, pLib)
    end
end

function world:drawCollectablesCollider(UI)
    for i, obj in pairs(self.milks, self.sugars) do
        if UI.isDebugging then
            if i=="milks" then
                love.graphics.setColor({ 0.8, 0, 0, 1 })
            else
                love.graphics.setColor({ 1, 0, 0, 1 })
            end
            love.graphics.rectangle("line", obj.x, obj.y, obj.width, obj.height)

            love.graphics.setColor({ 0, 0, 0, 1 })
            love.graphics.print(tostring(math.floor(obj.x)) .. "," .. tostring(math.floor(obj.y)), obj.x-5, obj.y-5, nil, 0.6)
        end
    end
end

function world:draw(UI, camera, cursor)
    self.map:drawLayer(self.map.layers["Ground"])
    self.map:drawLayer(self.map.layers["Grasses"])
    self.map:drawLayer(self.map.layers["Fences"])
    self.map:drawLayer(self.map.layers["House"])

    self:drawCollectables(camera, cursor)
    self:drawCollectablesCollider(UI)
end

return world
