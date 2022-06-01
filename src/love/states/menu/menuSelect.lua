--[[----------------------------------------------------------------------------
This file is part of Friday Night Funkin' Rewritten

Copyright (C) 2021  HTV04

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
------------------------------------------------------------------------------]]

local leftFunc, rightFunc, confirmFunc, backFunc, drawFunc

local menuState

local menuButton

local selectSound = love.audio.newSource("sounds/menu/select.ogg", "static")
local confirmSound = love.audio.newSource("sounds/menu/confirm.ogg", "static")

local function switchMenu(menu)
	menuState = 1
end

return { -- this menu went from depressing to even more depressing (I am sorry modders)
	enter = function(self, previous)
        changingMenu = false
        tweenedFreeplay = false
        function tweenButtons()
            if story.y == -400 then
                Timer.tween(1, story, {y = -200}, "out-expo")
            end
            if freeplayR.x == 400 then
                Timer.tween(1, freeplayR, {x = 120}, "out-expo")
            end
            if freeplayL.x == -400 then
                Timer.tween(1, freeplayL, {x = -120}, "out-expo", function() tweenedFreeplay = true end)
            end
            if options.y == 400 then
                Timer.tween(1, options, {y = 200}, "out-expo")
            end
            Timer.tween(0.3, titleBG, {y = 15}, "out-quad")
        end
		menuButton = 1
		songNum = 0
        titleBG = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/menuBG")))

        titleBG.sizeX, titleBG.sizeY = 1.15

        options = love.filesystem.load("sprites/menu/menuButtons.lua")()
        story = love.filesystem.load("sprites/menu/menuButtons.lua")()
        freeplayR = love.filesystem.load("sprites/menu/menuButtons.lua")()
        freeplayL = love.filesystem.load("sprites/menu/menuButtons.lua")()
        freeplay = love.filesystem.load("sprites/menu/menuButtons.lua")()

        story:animate("story hover", true)
        freeplayR:animate("freeplayR", true)
        freeplayL:animate("freeplayL", true)
        freeplay:animate("freeplay", true)
        options:animate("options", true)

        story.y = -400
        freeplayR.y, freeplayL.y = 0
        options.y = 400
        freeplayR.x, freeplayL.x = 400, -400
        freeplay.y = 0
        tweenButtons()

		cam.sizeX, cam.sizeY = 0.9, 0.9
		camScale.x, camScale.y = 0.9, 0.9
        Timer.after(
            0.8,
            function()
                Timer.tween(
                    0.42,
                    camScale,
                    {
                        x = 1,
                        y = 1
                    },
                    "out-expo"
                )
            end
        )
        

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
        freeplayR:update(dt)
        freeplayL:update(dt)
        freeplay:update(dt)

        if not music:isPlaying() then
			music:play()
		end

		if not graphics.isFading() then
			if input:pressed("up") then
				audio.playSound(selectSound)

                if menuButton ~= 1 then
                    menuButton = menuButton - 1
                else
                    menuButton = 3
                end -- change 3 to the amount of options there are.

                if menuButton == 1 then
                    story:animate("story hover", true)
                    freeplay:animate("freeplay", true)
                    options:animate("options", true)

                    Timer.tween(0.3, titleBG, {y = 15}, "out-quad")
                elseif menuButton == 2 then
                    story:animate("story", true)
                    freeplay:animate("freeplay hover", true)
                    options:animate("options", true)

                    Timer.tween(0.3, titleBG, {y = 0}, "out-quad")
                elseif menuButton == 3 then
                    story:animate("story", true)
                    freeplay:animate("freeplay", true)
                    options:animate("options hover", true)

                    Timer.tween(0.3, titleBG, {y = -15}, "out-quad")
                end

			elseif input:pressed("down") then
				audio.playSound(selectSound)

                if menuButton ~= 3 then
                    menuButton = menuButton + 1
                else
                    menuButton = 1
                end

                if menuButton == 1 then
                    story:animate("story hover", true)
                    freeplay:animate("freeplay", true)
                    freeplayL:animate("freeplayL", true)
                    freeplayR:animate("freeplayR", true)
                    options:animate("options", true)

                    Timer.tween(0.3, titleBG, {y = 15}, "out-quad")
                elseif menuButton == 2 then
                    story:animate("story", true)
                    freeplay:animate("freeplay hover", true)
                    freeplayL:animate("freeplayL hover", true)
                    freeplayR:animate("freeplayR hover", true)
                    options:animate("options", true)

                    Timer.tween(0.3, titleBG, {y = 0}, "out-quad")
                elseif menuButton == 3 then
                    story:animate("story", true)
                    freeplay:animate("freeplay", true)
                    freeplayL:animate("freeplayL", true)
                    freeplayR:animate("freeplayR", true)
                    options:animate("options hover", true)

                    Timer.tween(0.3, titleBG, {y = -15}, "out-quad")
                end

			elseif input:pressed("confirm") then
				audio.playSound(confirmSound)

				Timer.tween(0.3, titleBG, {y = 0}, "out-quad")
                if menuButton == 1 then
                    status.setLoading(true)
                    graphics.fadeOut(
                        0.3,
                        function()
                            Gamestate.switch(menuWeek)
                            status.setLoading(false)
                        end
	            	)
                    tweenedFreeplay = false
                    Timer.tween(0.9, story, {y = 0}, "out-expo")
                    Timer.tween(0.9, freeplayR, {x = 1000}, "out-expo")
                    Timer.tween(0.9, freeplayL, {x = -1000}, "out-expo")
                    Timer.tween(0.9, options, {y = 700}, "out-expo")
                elseif menuButton == 2 then
                    status.setLoading(true)
                    graphics.fadeOut(
                        0.3,
                        function()
                            Gamestate.switch(menuFreeplay)
                            status.setLoading(false)
                        end
	            	)
                    Timer.tween(0.9, story, {y = -700}, "out-expo")
                    Timer.tween(0.9, options, {y = 700}, "out-expo")
                elseif menuButton == 3 then
                    status.setLoading(true)
                    graphics.fadeOut(
                        0.3,
                        function()
                            Gamestate.switch(menuSettings)
                            status.setLoading(false)
                        end
	            	)
                    tweenedFreeplay = false
                    Timer.tween(0.9, options, {y = 0}, "out-expo")
                    Timer.tween(0.9, freeplayR, {x = 1000}, "out-expo")
                    Timer.tween(0.9, freeplayL, {x = -1000}, "out-expo")
                    Timer.tween(0.9, story, {y = -700}, "out-expo")
                end
                Timer.tween(1.1, camScale, {x = 4, y = 4}, "linear")
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
                love.graphics.scale(camScale.x, camScale.y)
			    titleBG:draw()
            love.graphics.pop()

            story:draw()
            options:draw()
            if not tweenedFreeplay then
                freeplayR:draw()
                freeplayL:draw()
            else
                freeplay:draw()
            end

			love.graphics.push()
				love.graphics.scale(cam.sizeX, cam.sizeY)
                love.graphics.color.printf(
                    "Vanilla Engine v1.0.0 pre-release 1" ..
                    "\nFNFR: v1.1.0-beta2",
                    -708,
                    340, 
                    833,
                    "left", 
                    nil, 
                    1, 
                    1, 
                    0, --R
                    0, --G
                    0, --B
                    1  --A
                )
			love.graphics.pop()
		love.graphics.pop()
	end,

	leave = function(self)
        titleBG = nil
        story = nil
        freeplay = nil
        options = nil
		Timer.clear()
	end
}
