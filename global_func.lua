local json = require('libs.json')

function Open_json(filename)
    local file = io.open(filename)
    local file_content=file:read("*a")
    return json.decode(file_content)
end

function Load_purple_img(file, w, h)
    local dat = love.image.newImageData(file)
    dat:mapPixel(function(x, y, r, g, b, a)
        if r == 1 and g == 0 and b == 1 then
            return 0, 0, 0, 0
        else
            return r, g, b, a
        end
    end, 0, 0, w, h)
    return love.graphics.newImage(dat)
end

function Box_to_Polygon(box)
    return {
        box.x, box.y,
        box.x + box.width, box.y,
        box.x + box.width, box.y + box.height,
        box.x, box.y + box.height
    }
end

function Bool_to_number(value)
    return value and 1 or 0
end

function Index(t, val)
    for i, v in ipairs(t) do
        if v == val then
            return i
        end
    end

    return nil
end

function Normalize(vector)
    local magnitude = 0

    -- Calculate the magnitude of the vector
    for i = 1, #vector do
        magnitude = magnitude + vector[i] * vector[i]
    end
    magnitude = math.sqrt(magnitude)

    -- Normalize the vector only if its magnitude is greater than 1
    if magnitude > 1 then
        for i = 1, #vector do
            vector[i] = vector[i] / magnitude
        end
    end

    return vector
end

function pairs(t, ...)
  local i, a, k, v = 1, {...}
  return
    function()
      repeat
        k, v = next(t, k)
        if k == nil then
          i, t = i + 1, a[i]
        end
      until k ~= nil or not t
      return k, v
    end
end
