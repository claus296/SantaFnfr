return {
    enter = function()
        stageImages = {

        }

        enemy = love.filesystem.load("sprites/Santa.lua")()
        enemy.colours = {255,0,0}

        girlfriend.x, girlfriend.y = -550, -500
        enemy.x, enemy.y = 120, 0
    end,

    load = function()

    end,

    update = function(self, dt)

    end,

    draw = function()
        love.graphics.push()
			love.graphics.translate(cam.x * 0.9, cam.y * 0.9)

		love.graphics.pop()
		love.graphics.push()
			love.graphics.translate(cam.x, cam.y)

			enemy:draw()
		love.graphics.pop()
		love.graphics.push()
			love.graphics.translate(cam.x * 1.1, cam.y * 1.1)

		love.graphics.pop()
    end,

    leave = function()
    
    end
}