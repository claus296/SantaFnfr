local parseXml = require "lib.xmlParser"

local Sprite = Object:extend()

local function startsWith(str, start) return string.sub(str, 1, #start) == start end
local function getCurFrame(spr)
    if spr.curAnim then
        return spr.curAnim.frames[math.floor(spr.curFrame)]
    elseif spr.__frames then
        return spr.__frames[1]
    end
    return nil
end

local newQuad = love.graphics.newQuad
function Sprite.newFrame(name, x, y, w, h, sw, sh, ox, oy, ow, oh)
    local aw, ah = x + w, y + h
    return {
        name = name,
        quad = newQuad(x, y, aw > sw and w - (aw - sw) or w,
                       ah > sh and h - (ah - sh) or h, sw, sh),
        width = ow == nil and w or ow,
        height = oh == nil and h or oh,
        offset = {x = ox == nil and 0 or ox, y = oy == nil and 0 or oy}
    }
end

function Sprite.getFramesFromSparrow(texture, description)
    if type(texture) == "string" then
        texture = love.graphics.newImage(texture)
    end

    local frames = {texture = texture, frames = {}}
    local sw, sh = texture:getDimensions()
    for _, c in ipairs(parseXml(description).TextureAtlas.children) do
        if c.name == "SubTexture" then
            table.insert(frames.frames,
                         Sprite.newFrame(c.attrs.name, tonumber(c.attrs.x),
                                         tonumber(c.attrs.y),
                                         tonumber(c.attrs.width),
                                         tonumber(c.attrs.height), sw, sh,
                                         tonumber(c.attrs.frameX),
                                         tonumber(c.attrs.frameY),
                                         tonumber(c.attrs.frameWidth),
                                         tonumber(c.attrs.frameHeight)))
        end
    end

    return frames
end

function Sprite:new(x, y, texture)
    if x == nil then x = 0 end
    if y == nil then y = 0 end
    self.x = x
    self.y = y

    self.texture = nil
    self.width, self.height = 0, 0
    self.antialiasing = true

    self.scale = {x = 1, y = 1}
    self.flipX = false
    self.flipY = false

    self.origin = {x = 0, y = 0}
    self.offset = {x = 0, y = 0}
    self.shear = {x = 0, y = 0}

    self.color = {1, 1, 1}
    self.alpha = 1
    self.angle = 0

    self.__frames = nil
    self.__animations = nil

    self.curAnim = nil
    self.curFrame = nil
    self.animFinished = nil
    self.animPaused = false

    if texture then self:load(texture) end
end

function Sprite:load(texture, width, height)
    if type(texture) == "string" then
        texture = love.graphics.newImage(texture)
    end
    self.texture = texture

    self.width = width
    if self.width == nil then self.width = self.texture:getWidth() end
    self.height = height
    if self.height == nil then self.height = self.texture:getHeight() end

    self.curAnim = nil
    self.curFrame = nil
    self.animFinished = nil
end

function Sprite:setFrames(frames)
    self.__frames = frames.frames
    self.texture = frames.texture

    local f = frames.frames[1]
    self:load(frames.texture, f.width, f.height)
    self:centerOrigin()
end

function Sprite:setGraphicSize(width, height)
    if width == nil then width = 0 end
    if height == nil then height = 0 end

    local f = getCurFrame(self)
    local w, h
    if not f then
        w, h = self.texture:getDimensions()
    else
        w, h = f.width, f.height
    end
    self.scale = {x = width / w, y = height / h}

    if width <= 0 then
        self.scale.x = self.scale.y
    elseif height <= 0 then
        self.scale.y = self.scale.x
    end
end

function Sprite:updateHitbox()
    local f = getCurFrame(self)
    local w, h
    if not f then
        w, h = self.texture:getDimensions()
    else
        w, h = f.width, f.height
    end

    self.width = math.abs(self.scale.x) * w
    self.height = math.abs(self.scale.y) * h

    self.offset = {x = -0.5 * (self.width - w), y = -0.5 * (self.height - h)}
    self:centerOrigin()
end

function Sprite:addOffset(name, x, y)
    local x = x or 0
    local y = y or 0
    self.__animations[name].frames.offset = {x = x, y = y}
end

function Sprite:centerOffsets()
    local f = getCurFrame(self)
    local w, h
    if not f then
        w, h = self.texture:getDimensions()
    else
        w, h = f.width, f.height
    end
    self.offset = {x = (w - self.width) * 0.5, y = (h - self.height) * 0.5}
end

function Sprite:centerOrigin()
    local f = getCurFrame(self)
    local w, h
    if not f then
        w, h = self.texture:getDimensions()
    else
        w, h = f.width, f.height
    end
    self.origin = {x = w * 0.5, y = h * 0.5}
end

function Sprite:addAnimByPrefix(name, prefix, framerate)
    if framerate == nil then framerate = 30 end

    local anim = {
        name = name,
        framerate = framerate,
        frames = {}
    }
    for _, f in ipairs(self.__frames) do
        if startsWith(f.name, prefix) then table.insert(anim.frames, f) end
    end

    if not self.__animations then self.__animations = {} end
    self.__animations[name] = anim
end

function Sprite:addAnimByIndices(name, prefix, indices, framerate)
    if framerate == nil then framerate = 30 end
    local anim = {
        name = name,
        framerate = framerate,
        frames = {}
    }
    local subEnd = #prefix + 1
    for _, i in ipairs(indices) do
        for _, f in ipairs(self.__frames) do
            if startsWith(f.name, prefix) and
                tonumber(string.sub(f.name, subEnd)) == i then
                table.insert(anim.frames, f)
                break
            end
        end
    end

    if not self.__animations then self.__animations = {} end
    self.__animations[name] = anim
end

function Sprite:setAnimSpeed(speed)
    if self.curAnim then self.curAnim.framerate = speed end
end

function Sprite:getAnimName()
    if self.curAnim then return self.curAnim.name end
end

function Sprite:isAnimated()
    return not self.animFinished
end

function Sprite:isAnimName(name)
    if self.__animations[name] then return true end
end

function Sprite:animate(anim, looped)
    self.curAnim = self.__animations[anim]
    self.curFrame = 1
    self.animFinished = false
    self.animPaused = false
    self.isLooped = looped
end

function Sprite:stop()
    if spr.curAnim then
        self.animFinished = true
        self.animPaused = true
    end
end

function Sprite:update(dt)
    if self.curAnim and not self.animFinished and not self.animPaused then
        self.curFrame = self.curFrame + self.curAnim.framerate * dt
        if self.curFrame >= #self.curAnim.frames then
            if self.isLooped then
                self.curFrame = 1
            else
                self.animFinished = true
            end
        end
    end
end

function Sprite:draw()
    if self.alpha > 0 or self.scale.x > 0 or self.scale.y > 0 then
        love.graphics.push()

        love.graphics.setColor(self.color[1], self.color[2], self.color[3],
                               self.alpha)

        local x, y, r, sx, sy, ox, oy, kx, ky =
            math.floor(self.width / 2) +
                math.floor(self.offset.x / (self.width - 1)) + self.x,
            math.floor(self.height / 2) +
                math.floor(self.offset.y / self.height) + self.y, self.angle,
            self.scale.x, self.scale.y, self.origin.x - 1, self.origin.y,
            self.shear.x, self.shear.y

        if self.flipX then sx = -sx end
        if self.flipY then sy = -sy end

        local min, mag, anisotropy = self.texture:getFilter()
        local mode = self.antialiasing and "linear" or "nearest"
        self.texture:setFilter(mode, mode, anisotropy)

        local f = getCurFrame(self)

        if not f then
            love.graphics.draw(self.texture, x, y, r, sx, sy, ox, oy, kx, ky)
        else
            ox = ox + f.offset.x
            oy = oy + f.offset.y

            love.graphics.draw(self.texture, f.quad, x, y, r, sx, sy, ox, oy,
                               kx, ky)
        end

        self.texture:setFilter(min, mag, anisotropy)

        love.graphics.pop()
    end
end

function Sprite:udraw(sizeX, sizeY)
    if self.alpha > 0 or self.scale.x > 0 or self.scale.y > 0 then
        love.graphics.push()

        love.graphics.setColor(self.color[1], self.color[2], self.color[3],
                               self.alpha)

        local x, y, r, sx, sy, ox, oy, kx, ky =
            math.floor(self.width / 2) +
                math.floor(self.offset.x / (self.width - 1)) + self.x,
            math.floor(self.height / 2) +
                math.floor(self.offset.y / self.height) + self.y, self.angle,
            self.scale.x, self.scale.y, self.origin.x - 1, self.origin.y,
            self.shear.x, self.shear.y

        if self.flipX then sx = -sx end
        if self.flipY then sy = -sy end

        local min, mag, anisotropy = self.texture:getFilter()
        local mode = self.antialiasing and "linear" or "nearest"
        self.texture:setFilter(mode, mode, anisotropy)

        local f = getCurFrame(self)

        if not f then
            love.graphics.draw(self.texture, x, y, r, sizeX or 7, sizeY or 7, ox, oy, kx, ky)
        else
            ox = ox + f.offset.x
            oy = oy + f.offset.y

            love.graphics.draw(self.texture, f.quad, x, y, r, sizeX or 7, sizeY or 7, ox, oy,
                               kx, ky)
        end

        self.texture:setFilter(min, mag, anisotropy)

        love.graphics.pop()
    end
end

return Sprite
