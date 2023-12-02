local cursor = {
    x = 0,
    y = 0,

    wx = 0,
    wy = 0,

    scale = 1,
    mode = 1,

    width = 1,
    height = 1,

    sprite = love.graphics.newImage('res/img/Cursor.png'),

    --Debug Variables
    isTouchingCollectables = false
}

function cursor:update(plr)
    self.x = love.mouse.getX()
    self.y = love.mouse.getY()

    love.mouse.setVisible(false)

    if self.mode == 1 then
        self.width = 1
        self.height = 1

        self.scale = 1

        self.sprite = love.graphics.newImage('res/img/Cursor.png')
    elseif self.mode == 2 then
        self.scale = 2

        self.width = 16 * self.scale
        self.height = 16 * self.scale

        self.sprite = love.graphics.newImage("res/img/Selecting_Cursor.png")
    end

    --Debugging shit
    self.isTouchingCollectables = false
    self.mode=1
end

function cursor:draw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.sprite, self.x, self.y, nil, self.scale)
end

return cursor
