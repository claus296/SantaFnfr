-- Coming in a later update
local arrows, sprites, keybinds
local inputList = {
    "gameLeft",
    "gameDown",
    "gameUp",
    "gameRight"
}
local curInput = inputList[i]
return {
    enter = function(self)
        keybinds = {
            [1] = customBindLeft,
            [2] = customBindDown,
            [3] = customBindUp,
            [4] = customBindRight
        }
        images = {
            notes = love.graphics.newImage(graphics.imagePath(noteskins[settings.noteSkins])),
        } 
        sprites = {
            leftArrow = love.filesystem.load("sprites/notes/" .. noteskins[settings.noteSkins] .. "/left-arrow.lua"),
		    downArrow = love.filesystem.load("sprites/notes/" .. noteskins[settings.noteSkins] .. "/down-arrow.lua"),
		    upArrow = love.filesystem.load("sprites/notes/" .. noteskins[settings.noteSkins] .. "/up-arrow.lua"),
		    rightArrow = love.filesystem.load("sprites/notes/" .. noteskins[settings.noteSkins] .. "/right-arrow.lua")
        }
        arrows = {
            sprites.leftArrow(),
			sprites.downArrow(),
			sprites.upArrow(),
			sprites.rightArrow()
        }
        for i = 1, 4 do
            arrows[i].x = -410 + 165 * i
        end
    end,
    update = function(self, dt)
        for i = 1, 4 do
            local curInput = inputList[i]
            _ARROW_ = arrows[i] 
            _ARROW_:update(dt)
            if input:pressed(curInput) then
                if not _ARROW_:getAnimName() == "confirm" then
                    _ARROW_:animate("confirm", false)
                end
            end
            if input:released(curInput) then
                _ARROW_:animate("off", false)
            end
        end
    end,
    keyPressed = function(self, key)
        if key == "escape" then
            Gamestate.pop()
        end
    end,
    draw = function(self)
        love.graphics.push()
			love.graphics.translate(lovesize.getWidth() / 2, lovesize.getHeight() / 2)
			love.graphics.scale(0.7, 0.7)
            
            for i = 1, 4 do 
                arrows[i]:draw()
            end

        love.graphics.pop()
    end
}