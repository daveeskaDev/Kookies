local camera = require('libs.camera')
local cam = camera()
cam.scale = 2.0

function cam:update()
    local player = require("lua.player")
    local world = require("lua.world")

    --Camera system
    self:lookAt(player.x, player.y)

    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()

    if self.x < w / 2 / self.scale then
        self.x = w / 2 / self.scale
    end

    if self.y < h / 2 / self.scale then
        self.y = h / 2 / self.scale
    end

    local mapW = world.map.width * world.map.tilewidth
    local mapH = world.map.height * world.map.tileheight

    if self.x > (mapW - w / 2 / self.scale) then
        self.x = (mapW - w / 2 / self.scale)
    end

    if self.y > (mapH - h / 2 / self.scale) then
        self.y = (mapH - h / 2 / self.scale)
    end
end

function cam:changeZoomLevel(y, UI)
    if UI.isDebugging == true then
        if y > 0 then
            cam.scale = cam.scale + 0.1
        elseif y < 0 then
            cam.scale = cam.scale - 0.1
        end
    end

end

return cam
