local pLib = require('lua.physics')

local player={
    x=257,
    y=480,

    hWidth=23,
    hHeight=10,

    hitbox = require('lua.player.hitbox'),

    scale=2.3,

    speed=200,

    animation=require('lua.player.animation'),

    inventory=require('lua.player.inventory')
}


function player:keypressed(key)
    --KeyCode
end

function player:load()
    --Collider
    player.collider = pLib.newRecCollider(player.x, player.y, player.hWidth, player.hHeight)
    player.collider:setFixedRotation(true)

    self.inventory:load()
end

function player:update(dt, world, cursor, camera)
    self:move(dt)
    self.animation:update(dt)

    self.hitbox:update(self, world, pLib, cursor, camera)
    self.inventory:update()

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

function player:draw(UI, world)
    self.animation.current_animation.anim:draw(self.animation.spriteSheet, self.x, self.y, nil, self.scale, nil, 6, 9)
    self.hitbox:draw(UI)
end

return player
