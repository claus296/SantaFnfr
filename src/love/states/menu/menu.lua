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

local upFunc, downFunc, confirmFunc, backFunc, drawFunc, musicStop

local menuState

local menuNum = 1

local songNum, songAppend
local songDifficulty = 2

local selectSound = love.audio.newSource("sounds/menu/select.ogg", "static")
local confirmSound = love.audio.newSource("sounds/menu/confirm.ogg", "static")

music = love.audio.newSource("songs/misc/menu.ogg", "stream")

local function switchMenu(menu)
	function backFunc()
		graphics.fadeOut(0.5, love.event.quit)
	end

	menuState = 1
end

music:setLooping(true)

return {
	enter = function(self, previous)

		function tweenMenu()
			if logo.y == -300 then 
				Timer.tween(1, logo, {y = -125}, "out-expo")
			end
			if titleEnter.y == 450 then 
				Timer.tween(1, titleEnter, {y = 350}, "out-expo")
			end
			if girlfriendTitle.x == 500 then
				Timer.tween(1, girlfriendTitle, {x = 400}, "out-expo")
			end
		end

		function logoRotate()
			Timer.tween(2, logo, {orientation = 0.15}, "in-out-back", function()
				Timer.tween(2, logo, {orientation = -0.15}, "in-out-back", function()
					logoRotate()
				end)
			end)
		end
		menuBPM = 102
		logo = love.filesystem.load("sprites/menu/ve-logo.lua")()
		girlfriendTitle = love.filesystem.load("sprites/menu/girlfriend-title.lua")()
		titleEnter = love.filesystem.load("sprites/menu/titleEnter.lua")()

		whiteRectangle1 = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/whiteRectangle")))
		whiteRectangle2 = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/whiteRectangle")))
		whiteRectangle3 = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/whiteRectangle")))
		whiteRectangle4 = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/whiteRectangle")))
		whiteRectangle5 = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/whiteRectangle")))
		whiteRectangle6 = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/whiteRectangle")))
		whiteRectangle7 = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/whiteRectangle")))
		whiteRectangle8 = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/whiteRectangle")))
		whiteRectangle9 = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/whiteRectangle")))
		whiteRectangle10 = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/whiteRectangle")))
		whiteRectangle11= graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/whiteRectangle")))
		whiteRectangle12 = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/whiteRectangle")))
		whiteRectangle13 = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/whiteRectangle")))
		whiteRectangle14 = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/whiteRectangle")))
		whiteRectangle15 = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/whiteRectangle")))   -- sorry guglio 



		whiteRectangle1.x = -680
		whiteRectangle2.x = -580
		whiteRectangle3.x = -480
		whiteRectangle4.x = -380
		whiteRectangle5.x = -280
		whiteRectangle6.x = -180
		whiteRectangle7.x = -80
		whiteRectangle8.x = 20
		whiteRectangle9.x = 120
		whiteRectangle10.x = 220
		whiteRectangle11.x = 320
		whiteRectangle12.x = 420
		whiteRectangle13.x = 520
		whiteRectangle14.x = 620
		whiteRectangle15.x = 720

		whiteRectangle1.y = -1000
		whiteRectangle2.y = -1000
		whiteRectangle3.y = -1000
		whiteRectangle4.y = -1000
		whiteRectangle5.y = -1000
		whiteRectangle6.y = -1000
		whiteRectangle7.y = -1000
		whiteRectangle8.y = -1000
		whiteRectangle9.y = -1000
		whiteRectangle10.y = -1000
		whiteRectangle11.y = -1000
		whiteRectangle12.y = -1000
		whiteRectangle13.y = -1000
		whiteRectangle14.y = -1000
		whiteRectangle15.y = -1000

		girlfriendTitle.x, girlfriendTitle.y = 500, 65
		titleEnter.x, titleEnter.y = 225, 450
		logo.x, logo.y = -350, -300

		logoRotate()
		tweenMenu()

		girlfriendTitle.x, girlfriendTitle.y = 325, 65

		titleEnter.x, titleEnter.y = 225, 350
		songNum = 0

		cam.sizeX, cam.sizeY = 0.9, 0.9
		camScale.x, camScale.y = 0.9, 0.9

		switchMenu(1)

		graphics.setFade(0)
		graphics.fadeIn(0.5)

		if useDiscordRPC then
			presence = {
				state = "Press Enter", 
				details = "In the Menu",
				largeImageKey = "logo",
				startTimestamp = now,
			}
			nextPresenceUpdate = 0
		end

		music:play()
	end,

	musicStop = function(self)
		music:stop()
	end,

	musicVolumeLower = function(self)
		music:setVolume(0.4)
	end,

	update = function(self, dt)
		girlfriendTitle:update(dt)
		titleEnter:update(dt)
		logo:update(dt)

		if not graphics.isFading() then
			if input:pressed("confirm") then
				audio.playSound(confirmSound)

				Timer.tween(0.1, whiteRectangle1, {y = 0}, "linear")
				Timer.tween(0.12, whiteRectangle2, {y = 0}, "linear")
				Timer.tween(0.13, whiteRectangle3, {y = 0}, "linear")
				Timer.tween(0.2, whiteRectangle4, {y = 0}, "linear")
				Timer.tween(0.22, whiteRectangle5, {y = 0}, "linear")
				Timer.tween(0.23, whiteRectangle6, {y = 0}, "linear")
				Timer.tween(0.3, whiteRectangle7, {y = 0}, "linear")
				Timer.tween(0.32, whiteRectangle8, {y = 0}, "linear")
				Timer.tween(0.33, whiteRectangle9, {y = 0}, "linear")
				Timer.tween(0.4, whiteRectangle10, {y = 0}, "linear")
				Timer.tween(0.42, whiteRectangle11, {y = 0}, "linear")
				Timer.tween(0.43, whiteRectangle12, {y = 0}, "linear")
				Timer.tween(0.5, whiteRectangle13, {y = 0}, "linear")
				Timer.tween(0.52, whiteRectangle14, {y = 0}, "linear")
				Timer.tween(0.53, whiteRectangle15, {y = 0}, "linear")  -- yes i know this is horrible

				titleEnter:animate("pressed", true)
				Timer.after(0.6, 
					function()
						graphics.fadeOut(
							0.3,
							function()
								Gamestate.switch(menuSelect)
								status.setLoading(false)
							end
						)
					end
				)	
			elseif input:pressed("back") then
				audio.playSound(selectSound)

				backFunc()
			end
		end
	end,

	draw = function(self)
		love.graphics.push()
			love.graphics.translate(graphics.getWidth() / 2, graphics.getHeight() / 2)

			love.graphics.push()
				love.graphics.scale(cam.sizeX, cam.sizeY)

				logo:draw()

				girlfriendTitle:draw()
				titleEnter:draw()

				--love.graphics.setColor(1, 63 / 255, 172 / 255, 0.9)
				love.graphics.setColor(1, 1, 1, 0.9)
				whiteRectangle1:draw()
				whiteRectangle2:draw()
				whiteRectangle3:draw()
				whiteRectangle4:draw()
				whiteRectangle5:draw()
				whiteRectangle6:draw()
				whiteRectangle7:draw()
				whiteRectangle8:draw()
				whiteRectangle9:draw()
				whiteRectangle10:draw()
				whiteRectangle11:draw()
				whiteRectangle12:draw()
				whiteRectangle13:draw()
				whiteRectangle14:draw()
				whiteRectangle15:draw()

				love.graphics.setColor(1, 1, 1)

				--love.graphics.printf(
				--	"This is a pre-release build.\n\n"..
				--	"Please report any bugs you find.",
				--	-525,
				--	90,
				--	1200,
				--	"left",
				--	nil,
				--	1.6,
				--	1.6
				--)

				love.graphics.pop()
		love.graphics.pop()
	end,

	leave = function(self)
		girlfriendTitle = nil
		titleEnter = nil
		logo = nil
		whiteRectangle1 = nil
		whiteRectangle2 = nil
		whiteRectangle3 = nil
		whiteRectangle4 = nil
		whiteRectangle5 = nil
		whiteRectangle6 = nil
		whiteRectangle7 = nil
		whiteRectangle8 = nil
		whiteRectangle9 = nil
		whiteRectangle10 = nil
		whiteRectangle11 = nil
		whiteRectangle12 = nil
		whiteRectangle13 = nil
		whiteRectangle14 = nil
		whiteRectangle15 = nil

		Timer.clear()
	end
}
