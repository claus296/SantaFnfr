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

local difficulty

return {
	enter = function(self, from, songNum, songAppend)
		weeks7:enter()
		stages["tank"]:enter()

		week = 7

		song = songNum
		difficulty = songAppend

		healthBarColorEnemy = {50,50,50}		

		enemyIcon:animate("tankman", false)

		self:load()
	end,

	load = function(self)
		weeks7:load()
		stages["tank"]:load()

		if song == 3 then
			boyfriend = love.filesystem.load("sprites/week7/bfAndGF.lua")()
			boyfriend.x, boyfriend.y = 380, 410
			fakeBoyfriend = love.filesystem.load("sprites/week7/gfdead.lua")()
			fakeBoyfriend.x, fakeBoyfriend.y = 380, 410

			inst = love.audio.newSource("songs/week7/stress/inst.ogg", "stream")
			voices = love.audio.newSource("songs/week7/stress/voices.ogg", "stream")
		elseif song == 2 then
			inst = love.audio.newSource("songs/week7/guns/inst.ogg", "stream")
			voices = love.audio.newSource("songs/week7/guns/voices.ogg", "stream")
		else
			inst = love.audio.newSource("songs/week7/ugh/inst.ogg", "stream")
			voices = love.audio.newSource("songs/week7/ugh/voices.ogg", "stream")
		end

		self:initUI()

		weeks7:setupCountdown()
	end,

	initUI = function(self)
		weeks7:initUI()

		if song == 3 then
			weeks7:generateNotes(love.filesystem.load("songs/week7/stress/" .. difficulty .. ".lua")())
            weeks7:generatePicoNotes(love.filesystem.load("songs/week7/stress/pico-speaker.lua")())
		elseif song == 2 then
			weeks7:generateNotes(love.filesystem.load("songs/week7/guns/" .. difficulty .. ".lua")())
		else
			weeks7:generateNotes(love.filesystem.load("songs/week7/ugh/" .. difficulty .. ".lua")())
		end
	end,

	update = function(self, dt)
		weeks7:update(dt)
		stages["tank"]:update(dt)

		if song == 1 then
			if musicTime >= 5620 then
				if musicTime <= 5720 then
					if enemy:getAnimName() == "up" then
						enemy:animate("ugh", false)
					end
				end
			end
			if musicTime >= 14620 then
				if musicTime <= 14720 then
					if enemy:getAnimName() == "up" then
						enemy:animate("ugh", false)
					end
				end
			end
			if musicTime >= 49120 then
				if musicTime <= 49220 then
					if enemy:getAnimName() == "up" then
						enemy:animate("ugh", false)
					end
				end
			end
			if musicTime >= 77620 then
				if musicTime <= 77720 then
					if enemy:getAnimName() == "up" then
						enemy:animate("ugh", false)
					end
				end
			end
		end

        if song == 3 then
			if musicTime >= 62083 then
				if musicTime <= 62083 + 50 then
					enemy:animate("good", false)
				end
			end
		end

		if health >= 80 then
			if enemyIcon:getAnimName() == "tankman" then
				enemyIcon:animate("tankman losing", false)
			end
		else
			if enemyIcon:getAnimName() == "tankman losing" then
				enemyIcon:animate("tankman", false)
			end
		end

		if not (countingDown or graphics.isFading()) and not (inst:isPlaying() and voices:isPlaying()) and not paused then
			if storyMode and song < 3 then
				song = song + 1

				self:load()
			else
				status.setLoading(true)

				graphics.fadeOut(
					0.5,
					function()
						if storyMode then
							Gamestate.switch(menuWeek)
						else
							Gamestate.switch(menuFreeplay)
						end

						status.setLoading(false)
					end
				)
			end
		end

		weeks7:updateUI(dt)
	end,

	draw = function(self)
		love.graphics.push()
			love.graphics.translate(graphics.getWidth() / 2, graphics.getHeight() / 2)
			love.graphics.scale(cam.sizeX, cam.sizeY)

			stages["tank"]:draw()

			weeks7:drawRating(0.9)
		love.graphics.pop()

		weeks7:drawHealthBar()
		weeks7:drawUI()
	end,

	leave = function(self)
		song = 1
		stages["tank"]:leave()
		weeks7:leave()
	end
}
