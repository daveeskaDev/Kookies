local anim8 = require('libs.anim8.anim8')

local function newAnimation(animation, name)
    return {
        anim = animation,
        name = name
    }
end

local animation = {
    spriteSheet = Load_purple_img("res/img/player/Player-SpriteSheet.png")
}

animation.grid = anim8.newGrid(18, 35, animation.spriteSheet:getDimensions())
animation.time_between_frames = 0.12
animation.time_between_idle_frames = 0.15

--Animations
animation.idle_down = newAnimation(anim8.newAnimation(animation.grid('1-5', 1), animation.time_between_idle_frames),
    "idle_down")
animation.walk_down = newAnimation(anim8.newAnimation(animation.grid('1-6', 2), animation.time_between_frames),
    "walk_down")

animation.idle_left = newAnimation(anim8.newAnimation(animation.grid('1-5', 3), animation.time_between_idle_frames),
    "idle_left")
animation.walk_left = newAnimation(anim8.newAnimation(animation.grid('1-6', 4), animation.time_between_frames),
    "walk_left")

animation.idle_up = newAnimation(anim8.newAnimation(animation.grid('1-5', 5), animation.time_between_idle_frames), "idle_up")
animation.walk_up = newAnimation(anim8.newAnimation(animation.grid('1-6', 6), animation.time_between_frames), "walk_up")

animation.idle_right = newAnimation(anim8.newAnimation(animation.grid('1-5', 7), animation.time_between_idle_frames),
    "idle_right")
animation.walk_right = newAnimation(anim8.newAnimation(animation.grid('1-6', 8), animation.time_between_frames),
    "walk_right")

animation.current_animation = animation.idle_down
animation.last_animation = animation.idle_down

function animation:update(dt)
    local isMoving = false

    if love.keyboard.isDown("w") then
        self.current_animation = self.walk_up
        self.last_animation = self.idle_up
        isMoving = true
    end

    if love.keyboard.isDown("a") then
        self.current_animation = self.walk_left
        self.last_animation = self.idle_left
        isMoving = true
    end

    if love.keyboard.isDown("s") then
        self.current_animation = self.walk_down
        self.last_animation = self.idle_down
        isMoving = true
    end

    if love.keyboard.isDown("d") then
        self.current_animation = self.walk_right
        self.last_animation = self.idle_right
        isMoving = true
    end

    --Checking if frame is standing still or animating
    if isMoving == false then
        self.current_animation = self.last_animation
    end

    self.current_animation.anim:update(dt)
end

return animation
