local function newSlot()
    return {
        p_x = 0,
        y = 32,
        items={}
    }
end

local inv = {
    items = {},

    p_x = -30,
    p_y = 32,

    p_width = 32 * 2.2,
    p_height = 32 * 2.2,

    slot = {},

    sprite = love.graphics.newImage('res/img/ui/InvPiece.png'),

    load = function(self)
        for i = 1, 6, 1 do
            table.insert(self.slot, newSlot())
        end

    end,

    update = function(self)
        for i, obj in pairs(self.slot) do
            table.insert(obj.items, self.items[i])
        end
    end,

    draw = function(self)
        for i,obj in ipairs(self.slot) do
            love.graphics.setColor(1,1,1,1)
            love.graphics.draw(self.sprite, self.p_x + i * self.p_width, self.p_y, nil, 2.2)
            if obj.items~=nil then
                --love.graphics.draw(obj.items[i].sprite, (self.p_x+i*self.p_width)+16, self.p_y+9.5, nil, 1.5)
            end
        end
    end
}
return inv
