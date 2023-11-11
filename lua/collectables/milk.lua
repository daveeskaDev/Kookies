New_milk = function(x, y)
math.randomseed(os.time())

love.graphics.setDefaultFilter("nearest", "nearest")
    return {
        sprite = Load_purple_img("res/img/Milk.png"),

        x = x,
        y = y,

        width = 15 * 1.3,
        height = 21 * 1.3,

        draw = function(self)
            love.graphics.draw(self.sprite, self.x, self.y, nil, 1.3)
        end
    }
end
