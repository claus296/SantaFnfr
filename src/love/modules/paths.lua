local function endsWith(str, ending)
    return ending == "" or string.sub(str, -#ending) == ending
end
local function isFile(path)
    local info = love.filesystem.getInfo(path)
    return info and info.type == "file"
end

local paths = {}

function paths.getText(key)
    local path = key
    if isFile(path) then
        local contents = love.filesystem.read(path)
        return contents
    end
    return nil
end

function paths.getJSON(key) return decodeJson(paths.getText(key .. ".json")) end

function paths.getImage(key)
    local path = graphics.imagePath(key)
    if isFile(path) then
        return love.graphics.newImage(path)
    end

    return nil
end

function paths.getSparrowFrames(key)
    local xmlKey = "sprites/" .. key .. ".xml"
    local img, path = paths.getImage(key), xmlKey
    if img and isFile(path) then
        return Sprite.getFramesFromSparrow(img, paths.getText(xmlKey))
    end

    return nil
end

return paths
