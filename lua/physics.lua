--Physics
local wf = require('libs.windfield')
local pWorld = wf.newWorld(0, 0)

local pLib = {
    drawCollider = function ()
        pWorld:draw()
    end,

    updateCollider = function(dt)
        pWorld:update(dt)
    end,

    newRecCollider = function(x,y,w,h)
        return pWorld:newRectangleCollider(x, y, w, h)
    end,

    newPolygonCollider = function(vertices)
        return pWorld:newPolygonCollider(vertices)
    end,

    newBSGRecCollider = function(x,y,w,h, corner_size)
        return pWorld:newBSGRectangleCollider(x, y, w, h, corner_size)
    end,

    collideWith = function(p1, p2)
        return p1.x < p2.x + p2.width and
        p1.x + p1.width > p2.x and
        p1.y < p2.y + p2.height and
        p1.y + p1.height > p2.y
    end
}

return pLib
