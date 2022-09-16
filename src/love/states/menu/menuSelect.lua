local leftFunc, rightFunc, confirmFunc, backFunc, drawFunc

local menuState

local menuButton

local selectSound = love.audio.newSource("sounds/menu/select.ogg", "static")
local confirmSound = love.audio.newSource("sounds/menu/confirm.ogg", "static")

local function switchMenu(menu)
	menuState = 1
end

return {
	enter = function(self, previous)
        
		menuButton = 1
		songNum = 0
        titleBG = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/menuBG")))

        titleBG.sizeX, titleBG.sizeY = 1.15
        cam.sizeX, cam.sizeY = 0.9,0.9
        cam.x, cam.y = 0, 0

        options = love.filesystem.load("sprites/menu/menuButtons.lua")()
        story = love.filesystem.load("sprites/menu/menuButtons.lua")()
        freeplay = love.filesystem.load("sprites/menu/menuButtons.lua")()
        credits = love.filesystem.load("sprites/menu/credits.lua")()
        story:animate("story hover", true)
        freeplay:animate("freeplay", true)
        options:animate("options", true)
        credits:animate("credits", true)
        story.y,freeplay.y,options.y,credits.y = 600, 600, 600, 600
        Timer.tween(1, story, {y = -200}, "out-expo")
        Timer.tween(1, freeplay, {y = -50}, "out-expo")
        Timer.tween(1, options, {y = 100}, "out-expo")
        Timer.tween(1, credits, {y = 250}, "out-expo")
        Timer.tween(0.88, cam, {y = 35, sizeX = 1.1, sizeY = 1.1}, "out-quad")

        function changeSelect()
            if menuButton == 1 then
                story:animate("story hover", true)
                freeplay:animate("freeplay", true)
                options:animate("options", true)
                credits:animate("credits", true)

                Timer.tween(0.3, cam, {y = 35}, "out-quad")
            elseif menuButton == 2 then
                story:animate("story", true)
                freeplay:animate("freeplay hover", true)
                options:animate("options", true)
                credits:animate("credits", true)

                Timer.tween(0.3, cam, {y = 15}, "out-quad")
            elseif menuButton == 3 then
                story:animate("story", true)
                freeplay:animate("freeplay", true)
                options:animate("options hover", true)
                credits:animate("credits", true)

                Timer.tween(0.3, cam, {y = -15}, "out-quad")
            elseif menuButton == 4 then
                story:animate("story", true)
                freeplay:animate("freeplay", true)
                options:animate("options", true)
                credits:animate("credits hover", true)
                Timer.tween(0.3, cam, {y = -35}, "out-quad")
            end
        end

        function confirmFunc()
            if menuButton == 1 then
                status.setLoading(true)
                graphics.fadeOut(
                    0.3,
                    function()
                        Gamestate.switch(menuWeek)
                        status.setLoading(false)
                    end
                )
                Timer.tween(0.9, story, {y = 0}, "out-expo")
                Timer.tween(0.9, freeplay, {y = 700}, "out-expo")
                Timer.tween(0.9, options, {y = 700}, "out-expo")
                Timer.tween(0.9, credits, {y = 700}, "out-expo")
            elseif menuButton == 2 then
                status.setLoading(true)
                graphics.fadeOut(
                    0.3,
                    function()
                        if mods.weekMeta[1] then
                            Gamestate.switch(menuChooseFreeplay)
                        else
                            Gamestate.switch(menuFreeplay)
                        end
                        status.setLoading(false)
                    end
                )
                Timer.tween(0.9, freeplay, {y = 0}, "out-expo")
                Timer.tween(0.9, story, {y = -700}, "out-expo")
                Timer.tween(0.9, options, {y = 700}, "out-expo")
                Timer.tween(0.9, credits, {y = 700}, "out-expo")
            elseif menuButton == 3 then
                status.setLoading(true)
                graphics.fadeOut(
                    0.3,
                    function()
                        Gamestate.push(menuSettings)
                        status.setLoading(false)
                    end
                )
                Timer.tween(0.9, freeplay, {y = -700}, "out-expo")
                Timer.tween(0.9, options, {y = 0}, "out-expo")
                Timer.tween(0.9, story, {y = -700}, "out-expo")
                Timer.tween(0.9, credits, {y = 700}, "out-expo")
            elseif menuButton == 4 then
                status.setLoading(true)
                graphics.fadeOut(
                    0.3,
                    function()
                        Gamestate.switch(menuCredits)
                        status.setLoading(false)
                    end
                )
                Timer.tween(0.9, credits, {y = 0}, "out-expo")
                Timer.tween(0.9, options, {y = -700}, "out-expo")
                Timer.tween(0.9, freeplay, {y = -700}, "out-expo")
                Timer.tween(0.9, story, {y = -700}, "out-expo")
            end
            Timer.tween(1.1, cam, {sizeX = 4, sizeY = 4}, "linear")
        end

		switchMenu(1)

		graphics.setFade(0)
		graphics.fadeIn(0.5)

        if useDiscordRPC then
            presence = {
                state = "Choosing a mode",
                details = "In the Main Menu",
                largeImageKey = "logo",
                startTimestamp = now,
            }
            nextPresenceUpdate = 0
        end

	end,

	update = function(self, dt)
        options:update(dt)
        story:update(dt)
        freeplay:update(dt)
        credits:update(dt)

		if not graphics.isFading() then
			if input:pressed("up") then
				audio.playSound(selectSound)

                if menuButton ~= 1 then
                    menuButton = menuButton - 1
                else
                    menuButton = 4
                end -- change 3 to the amount of options there are.

                changeSelect()

			elseif input:pressed("down") then
				audio.playSound(selectSound)

                if menuButton ~= 4 then
                    menuButton = menuButton + 1
                else
                    menuButton = 1
                end

                changeSelect()

			elseif input:pressed("confirm") then
				audio.playSound(confirmSound)

				confirmFunc()
			elseif input:pressed("back") then
				audio.playSound(selectSound)

				Gamestate.switch(menu)
			end
		end
	end,

	draw = function(self)
		love.graphics.push()
			love.graphics.translate(graphics.getWidth() / 2, graphics.getHeight() / 2)
            
            love.graphics.push()
                love.graphics.translate(cam.x, cam.y)
                love.graphics.scale(cam.sizeX, cam.sizeY)
			    titleBG:draw()
            love.graphics.pop()
            love.graphics.translate(cam.x, cam.y*0.82)
            story:draw()
            options:draw()
            freeplay:draw()
            credits:draw()
		love.graphics.pop()
        
	end,

	leave = function(self)
        titleBG = nil
        story = nil
        freeplay = nil
        options = nil
        credits = nil
		Timer.clear()
	end
}