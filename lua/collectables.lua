New_collectables = function(x, y, id)
    return {
        x = x,
        y = y,

        id = id,

        load = function(self)
            if self.id == 1 then
                self.width = 27 * .7
                self.height = 35 * .7
                self.scale = .7

                self.sprite = Load_purple_img("res/img/Sugar.png")
            elseif self.id == 2 then
                self.width = 15 * 1.2
                self.height = 21 * 1.2
                self.scale = 1.2

                self.sprite = Load_purple_img("res/img/Milk.png")
            end
        end,

        draw = function(self, camera, cursor, pLib)
            love.graphics.draw(self.sprite, self.x, self.y, nil, self.scale)
            --Green box when cursor touches collectables
            local box = {
                x = self.x,
                y = self.y,
                width = self.width*camera.scale,
                height = self.height*camera.scale
            }
            box.x, box.y = camera:cameraCoords(self.x, self.y)
            if pLib.collideWith(cursor, box) then
                love.graphics.setColor(0,1,0,0.7)
                love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
            end
        end
    }
end
