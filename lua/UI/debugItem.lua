local function debugItem(text, value, id)
    return {
        text = text,
        value = value,
        id=id
    }
end

local debugVar = {
    fps = debugItem("FPS: ", 0, 1),

    posX = debugItem("Pos(x): ", 0, 2),
    posY = debugItem("Pos(y): ", 0, 3),

    cam_scale = debugItem("Camera Scale: ", 1, 5),
    current_animation = debugItem("Current Frame: ", "", 6),

    sugar_count = debugItem("Total Sugar: ", 0, 8),
    milk_count = debugItem("Total Milk: ", 0, 9),

    invsugar = debugItem("Inv.Sugar: ", 0, 11),
    invegg = debugItem("Inv.milks: ", 0, 12),
    invchcookies = debugItem("Inv.chcookies: ", 0, 13),

    near_collectables = debugItem("Is Colliding With Collectable: ", false, 15),
    mouse_near_collectables = debugItem("Is Mouse Colliding With Collectable: ", false, 16),
    near_factoryarea = debugItem("Is Inside Factory: ", false, 17),

    total_walls = debugItem("Total Walls: ", 0, 19),

    mouse_x = debugItem("Mouse X: ", 0, 21),
    mouse_y = debugItem("Mouse Y: ", 0, 22),
}

function debugVar:update()
    local plr = require("lua.player")
    local wrld = require("lua.world")

    self.fps.value = love.timer.getFPS()

    self.posX.value = math.floor(plr.x)
    self.posY.value = math.floor(plr.y)

    self.current_animation.value = plr.animation.current_animation.name

    self.cam_scale.value = plr.camera.scale

    self.sugar_count.value = #wrld.sugars
    self.milk_count.value = #wrld.milks

    self.near_collectables.value = plr.hitbox.isTouchingCollectables
    self.mouse_near_collectables.value = plr.hitbox.isMouseTouchingCollectables
    self.near_factoryarea.value = plr.hitbox.isTouchingFactory

    self.invsugar.value = plr.inventory.sugars
    self.invegg.value = plr.inventory.milks
    self.invchcookies.value = plr.inventory.chcookies

    self.total_walls.value = #wrld.walls

    self.mouse_x.value = love.mouse.getX()
    self.mouse_y.value = love.mouse.getY()
end

function debugVar:draw()
    for _, obj in pairs(debugVar) do
        if type(obj) == "table" then
            love.graphics.setColor({0,1,0,1})
            love.graphics.print(obj.text .. tostring(obj.value), 0, obj.id * 20 - 20, nil, 2)
        end
    end
end

return debugVar
