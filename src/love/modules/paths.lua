local paths = {}

function paths.get(key) return key end

function paths.file(key)
    local contents = love.filesystem.read(paths.get(key))
    return contents
end

function paths.image(key)
    return love.graphics.newImage(graphics.imagePath(key))
end

function paths.json(key) return paths.file("data/" .. key .. ".json") end

function paths.xml(key) return paths.file(key .. ".xml") end

function paths.sprite(x, y, key)
    return sprite(
        x, y
    ):load(
        paths.image(key), 
        paths.xml("sprites/" .. key)
    )
end

function paths.soundPath(key, prefix)
    return paths.get((prefix or "sounds") .. "/" .. key .. ".ogg")
end

function paths.sound(key, cache, mode, prefix)
    if cache == nil then cache = true end

    local sound = love.audio.newSource(paths.soundPath(key, prefix), mode or "static")

    return sound
end

function paths.musicPath(key) return paths.soundPath(key, "music") end

function paths.music(key, cache, mode) return paths.sound(key, cache, mode, "music") end

return paths
