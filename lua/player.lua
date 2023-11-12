local pLib = require('lua.physics')

local player={
    x=984,
    y=500,

    hWidth=23,
    hHeight=10,

    hitbox = require('lua.player.hitbox'),

    scale=2.3,

    speed=200,

    camera=require('lua.player.camera'),
    animation=require('lua.player.animation'),

    inventory={
        sugars=0,
        milks=0,
        cookies=0,
    },

}

--Collider
player.collider = pLib.newRecCollider(player.x, player.y, player.hWidth, player.hHeight)
player.collider:setFixedRotation(true)

function player:keypressed(key)
    self.hitbox:changeDrawVar(key)
end

function player:update(dt)
    self.isTouchingCollectables = false
    self.isTouchingFactory = false

    self:move(dt)
    self.animation:update(dt)
    self.camera:update()

    self.hitbox:update(self)

    self.x = self.collider:getX() - 10
    self.y = self.collider:getY() - 50
end

function player:move(dt)
    local inputX = Bool_to_number(love.keyboard.isDown("d")) - Bool_to_number(love.keyboard.isDown("a"))
    local vx = inputX * self.speed * dt
    local inputY = Bool_to_number(love.keyboard.isDown("w")) - Bool_to_number(love.keyboard.isDown("s"))
    local vy = inputY * self.speed * -1 * dt

    local normalizedVector = Normalize({ vx, vy })

    self.collider:setLinearVelocity(normalizedVector[1] * self.speed, normalizedVector[2] * self.speed)

end

function player:draw()
    self.animation.current_animation.anim:draw(self.animation.spriteSheet, self.x, self.y, nil, self.scale, nil, 6, 9)
    self.hitbox:draw()
end

return player
