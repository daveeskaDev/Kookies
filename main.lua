love.graphics.setDefaultFilter("nearest", "nearest")

require('global_func')

local world = require('lua.world')
local player = require('lua.player')
local cam = require('lua.player.camera')
local pLib = require('lua.physics')
local UI = require('lua.UI')
local cursor = require('lua.cursor')

local fullscreen = true

function love.load()
    world:load()
end

function love.wheelmoved(x, y)
    cam:changeZoomLevel(y, UI)
end

function love.keypressed(key)
    UI:activateDebug(key)
    player:keypressed(key)

    if key=="f11" then
        fullscreen = not fullscreen
    end

end

function love.update(dt)
    love.window.setFullscreen(fullscreen)

    world:update(dt)
    cursor:update()
    player:update(dt)

    pLib.updateCollider(dt)

    UI:update()
end

function love.draw()
    love.graphics.setNewFont("res/fonts/Swansea.ttf", 13)

    cam:attach()

    love.graphics.setColor({1,1,1,1})
    world:draw()

    love.graphics.setColor({1,1,1,1})
    player:draw()

    if UI.isDebugging then
        pLib.drawCollider()
    end

    cam:detach()

    UI:draw()
    cursor:draw()
end
