local inv = {
    sugars = {slot=0, details={}},
    milks = {slot=1, details={}},
    cookies = {slot=2, details={}},

    x = -30,
    y = 32,

    width = 32 * 2.2,
    height = 32 * 2.2,

    slot = 3,

    sprite = love.graphics.newImage('res/img/ui/InvPiece.png'),

    draw = function(self)
        for _,obj in pairs(self.sugars.details, self.milks.details, self.cookies.details) do
        end

        for i = 1, self.slot do
            love.graphics.draw(self.sprite, self.x + i * self.width, self.y, nil, 2.2)
        end
    end
}
return inv
