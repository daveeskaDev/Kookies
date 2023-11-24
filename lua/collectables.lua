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

        draw = function(self)
            love.graphics.draw(self.sprite, self.x, self.y, nil, self.scale)
        end
    }
end
