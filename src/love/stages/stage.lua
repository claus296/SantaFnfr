return {
    enter = function()
        stageImages = {

        }

        enemy = Character.santa(0,0)
        love.graphics.setBackgroundColor(255,255,255)

        girlfriend.x, girlfriend.y = -550, -500
        enemy.x, enemy.y = -150, -500
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
        love.graphics.setBackgroundColor(0,0,0)
    end
}