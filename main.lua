math.randomseed(os.time())
love.graphics.setDefaultFilter("nearest", "nearest")

require('global_func')

local world = require('lua.world')
local player = require('lua.player')
local cam = require('lua.player.camera')
local pLib = require('lua.physics')
local UI = require('lua.UI')

function love.load()
    world:load()
end

function love.wheelmoved(x, y)
    cam:changeZoomLevel(y, UI)
end

function love.keypressed(key)
    UI:activateDebug(key)
    player:keypressed(key)
end

function love.update(dt)
    world:update(dt)
    player:update(dt)

    pLib.updateCollider(dt)

    UI:update()
end

function love.draw()
    cam:attach()
    world:draw()
    player:draw()
    if UI.isDebugging then
        pLib.drawCollider()
    end
    cam:detach()

    UI:draw()
end
