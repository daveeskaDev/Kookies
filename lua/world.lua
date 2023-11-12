local sti = require('libs.sti')

local pLib = require('lua.physics')
local UI = require('lua.UI')

--Collectables
require('lua.collectables.sugar')
require('lua.collectables.milk')

local world = {
    map = sti('res/map/SpawnPoint.lua'),

    walls = {},

    sugars = {},
    milks = {}
}

function world:spawnCollectables()
    if world.map.layers["CollectableArea"] and world.map.layers["CollectableArea"].objects then
        for _, obj in pairs(world.map.layers["CollectableArea"].objects) do
            local probability = love.math.random(4)
            if probability == 1 then
                local sugar = New_sugar(obj.x, obj.y)
                table.insert(world.sugars, sugar)
            end
            if probability == 2 then
                local milk = New_milk(obj.x, obj.y)
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

function world:update(dt)
    --TODO: Update Code
end

function world:drawCollectablesCollider()
    for _, obj in ipairs(world.sugars) do
        obj:draw()
        if UI.isDebugging then
            love.graphics.rectangle("line", obj.x, obj.y, obj.width, obj.height)
        end
    end
    for _, obj in ipairs(world.milks) do
        obj:draw()
        if UI.isDebugging then
            love.graphics.rectangle("line", obj.x, obj.y, obj.width, obj.height)
        end
    end
end

function world:draw()
    self.map:drawLayer(self.map.layers["Ground"])
    self.map:drawLayer(self.map.layers["Grasses"])
    self.map:drawLayer(self.map.layers["Fences"])
    self.map:drawLayer(self.map.layers["House"])

    self:drawCollectablesCollider()
end

return world
