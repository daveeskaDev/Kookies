love.graphics.setDefaultFilter("nearest", "nearest")

require('global_func')

local world = require('lua.world')
local player = require('lua.player')
local cam = require('lua.player.camera')
local pLib = require('lua.physics')
local cursor = require('lua.cursor')
local UI = require('lua.UI')

local fullscreen = true

function love.load()
    world:load()

    UI:load(player, world, cursor, cam)
end

function love.wheelmoved(x, y)
    cam:changeZoomLevel(y, UI)
end

function love.keypressed(key)
    UI:activateDebug(key)
    player:keypressed(key)

    if key == "f11" then
        fullscreen = not fullscreen
    end
end

function love.update(dt)
    love.window.setFullscreen(fullscreen)

    world:update()
    cursor:update()
    player:update(dt, world, cursor, cam)
    cam:update()

    pLib.updateCollider(dt)

    UI:update(player)
end

function love.draw()
    love.graphics.setNewFont("res/fonts/Swansea.ttf", 13)

    cam:attach()

    love.graphics.setColor({ 1, 1, 1, 1 })
    world:draw(UI, cam, cursor)

    love.graphics.setColor({ 1, 1, 1, 1 })
    player:draw(UI, world)

    if UI.isDebugging then
        pLib.drawCollider()
    end

    cam:detach()

    UI:draw(player)
    cursor:draw()
end
