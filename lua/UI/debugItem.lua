local function newDebugItem(text, value, id, table_source, source)
    return {
        text = text,
        value = value,
        id = id,
        update = function(self)
            self.value = table_source[source]
        end
    }
end

local debugVar = {
    load = function(self, plr, cursor, wrld, camera)
        self.fps = newDebugItem("FPS: ", 0, 1, wrld, "FPS")

        self.posX = newDebugItem("Pos(x): ", 0, 2, plr, "x")
        self.posY = newDebugItem("Pos(y): ", 0, 3, plr, "y")

        self.cam_scale = newDebugItem("Camera Scale: ", 1, 5, camera, "scale")
        self.current_animation = newDebugItem("Current Frame: ", "", 6, plr.animation.current_animation, "name")
        self.last_animation = newDebugItem("Last Frame: ", "", 7, plr.animation.last_animation, "name")

        self.sugar_count = newDebugItem("Total Sugar: ", 0, 9, wrld, "sugar_count")
        self.milk_count = newDebugItem("Total Milk: ", 0, 10, wrld, "milk_count")

        self.invsugar = newDebugItem("Inv.Sugar: ", 0, 12, plr.inventory, "sugars")
        self.invmilks = newDebugItem("Inv.milks: ", 0, 13, plr.inventory, "milks")
        self.invchcookies = newDebugItem("Inv.chcookies: ", 0, 14, plr.inventory, "cookies")

        self.near_collectables = newDebugItem("Is Colliding With Collectable: ", false, 16,
        plr.hitbox, "isTouchingCollectables")
        self.mouse_near_collectables = newDebugItem("Is Mouse Colliding With Collectable: ",
        false, 17, cursor, "isTouchingCollectables")

        self.total_walls = newDebugItem("Total Walls: ", 0, 19, wrld, "wall_count")

        self.mouse_x = newDebugItem("Mouse X: ", 0, 21, cursor, "x")
        self.mouse_y = newDebugItem("Mouse Y: ", 0, 22, cursor, "y")

        self.cam_x = newDebugItem("Camera X: ", 0, 24, camera, "x")
        self.cam_y = newDebugItem("Camera Y: ", 0, 25, camera, "y")
    end
}

function debugVar:update(plr)
    for _,obj in pairs(self) do
        if type(obj) == "table" then
            obj:update()
        end
    end

    self.posX.value = math.floor(self.posX.value)
    self.posY.value = math.floor(self.posY.value)

    self.cam_x.value = math.floor(self.cam_x.value)
    self.cam_y.value = math.floor(self.cam_y.value)

    self.invsugar.value = #plr.inventory.sugars["details"]
    self.invmilks.value = #plr.inventory.milks["details"]
    self.invchcookies.value = #plr.inventory.cookies["details"]
end

function debugVar:draw()
    for _, obj in pairs(debugVar) do
        if type(obj) == "table" then
            love.graphics.setColor({ 0.8, 1, 0, 1 })
            love.graphics.print(obj.text .. tostring(obj.value), 0, obj.id * 20 - 20, nil, 2)
        end
    end
end

return debugVar
