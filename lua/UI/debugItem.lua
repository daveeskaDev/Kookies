local function debugItem(text, value, id, table_source, source)
    return {
        text = text,
        value = value,
        id=id,
        update = function(self)
            self.value = table_source[source]
        end
    }
end

local debugVar = {
    load = function(self, plr, cursor, wrld)
        self.self.fps = debugItem("FPS: ", 0, 1)

        self.posX = debugItem("Pos(x): ", 0, 2, plr, "x")
        self.posY = debugItem("Pos(y): ", 0, 3, plr, "y")

        self.cam_scale = debugItem("Camera Scale: ", 1, 5, plr.camera, "scale")
        self.current_animation = debugItem("Current Frame: ", "", 6, plr.animation.current_animation, "name")

        self.sugar_count = debugItem("Total Sugar: ", 0, 8, wrld, "sugar_count")
        self.milk_count = debugItem("Total Milk: ", 0, 9, wrld, "milk_count")

        self.invsugar = debugItem("Inv.Sugar: ", 0, 11, plr.inventory, "sugars")
        self.invegg = debugItem("Inv.milks: ", 0, 12, plr.inventory, "milks")
        self.invchcookies = debugItem("Inv.chcookies: ", 0, 13, plr.inventory, "cookies")

        self.near_collectables = debugItem("Is Colliding With Collectable: ", false, 15,
            plr.hitbox, "isTouchingCollectables")
        self.mouse_near_collectables = debugItem("Is Mouse Colliding With Collectable: ",
            false, 16, plr.hitbox, "isMouseTouchingCollectables")

        self.total_walls = debugItem("Total Walls: ", 0, 18, wrld, "wall_count")

        self.mouse_x = debugItem("Mouse X: ", 0, 20, cursor, "x")
        self.mouse_y = debugItem("Mouse Y: ", 0, 21, cursor, "y")
    end
}

function debugVar:update()
    self.fps.value = love.timer.getFPS()

    for i,obj in pairs(self) do
        if type(obj) == table and i ~= "fps" then
            obj:update()
        end
    end
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
