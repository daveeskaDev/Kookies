local cursor={
    x=0,
    y=0,

    wx=0,
    wy=0,

    scale=1,

    width=18,
    height=28,

    sprite=love.graphics.newImage('res/img/Cursor.png'),

    --Debug Variables
    isTouchingCollectables=false
}

function cursor:update(plr)
    self.x = love.mouse.getX()
    self.y = love.mouse.getY()

    love.mouse.setVisible(false)

    --Debugging shit
    self.isTouchingCollectables = false
end

function cursor:draw()
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(self.sprite, self.x, self.y, nil, self.scale)
end

return cursor
