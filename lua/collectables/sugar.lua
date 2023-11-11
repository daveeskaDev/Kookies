New_sugar = function(x, y)
    return {
        sprite = Load_purple_img("res/img/Sugar.png"),

        x = x,
        y = y,

        width = 27 * .7,
        height = 35 * .7,

        draw = function(self)
            love.graphics.draw(self.sprite, self.x, self.y, nil, .7)
        end
    }
end
