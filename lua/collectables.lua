New_collectables = function(x, y, id)
    return {
        x = x,
        y = y,

        id = id,

        load = function(self)
            --opening json
            local items = {}
            local files=love.filesystem.getDirectoryItems('res/Collectables')
            for i=1,#love.filesystem.getDirectoryItems('res/Collectables') do
                local filename='res/Collectables/'..files[i]
                table.insert(items, Open_json(tostring(filename)))
            end

            --Inserting values from json
            for _,obj in pairs(items) do
                if self.id == obj.id then
                    self.width=obj["width"]
                    self.height=obj["height"]

                    self.scale=obj["scale"]

                    self.sprite=Load_purple_img(obj["sprite"])
                end
            end
        end,

        draw = function(self, camera, cursor, pLib, UI)
            love.graphics.draw(self.sprite, self.x, self.y, nil, self.scale)
            --Green box when cursor touches collectables
            local box = {
                x = self.x,
                y = self.y,
                width = self.width*camera.scale,
                height = self.height*camera.scale
            }
            box.x, box.y = camera:cameraCoords(self.x, self.y)
            if pLib.collideWith(cursor, box) then
                love.graphics.setColor(0,1,0,0.7)
                love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
            end

            if UI.isDebugging then
                love.graphics.setColor(0.83,0.2,0.23,1)
                love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
                love.graphics.setColor(0,0,0,1)
                love.graphics.print(tostring(math.floor(self.x)) .. "," .. tostring(math.floor(self.y)), self.x-5, self.y-5, nil, 0.6)
            end

        end
    }
end
