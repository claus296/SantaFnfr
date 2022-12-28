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

local stageBack, stageFront, curtains

return {
	enter = function(self, from, songNum, songAppend)
		pauseColor = {129, 100, 223}
		weeks:enter()
		stages["stage"]:enter()
		cam.sizeX, cam.sizeY = 0.7, 0.7
		camScale.x, camScale.y = 0.7, 0.7
		bgFade = 1

		week = 1

		song = songNum
		difficulty = songAppend

		weeks:setIcon("enemy", "daddy dearest")

		self:load()
	end,

	load = function(self)
		weeks:load()

		inst = waveAudio:newSource("songs/pissed-off/inst.ogg", "stream")
		voices = waveAudio:newSource("songs/pissed-off/voices.ogg", "stream")

		self:initUI()

		weeks:setupCountdown()
	end,

	initUI = function(self)
		weeks:initUI()

		weeks:generateNotes("songs/pissed-off/pissed-off.json")
	end,

	update = function(self, dt)
		weeks:update(dt)
		stages["stage"]:update(dt)

		if musicTime >= 73714.2857142858 then
			if musicTime <= 73714.2857142858 + 50 then
				enemy:animate("shoot", false)
			end
		end
		if musicTime >= 73714.2857142858 + 1700 then
			bgFade = bgFade - 0.01
		end

		if health >= 80 then
			if enemyIcon:getAnimName() == "daddy dearest" then
				weeks:setIcon("enemy", "daddy dearest losing")
			end
		else
			if enemyIcon:getAnimName() == "daddy dearest losing" then
				weeks:setIcon("enemy", "daddy dearest")
			end
		end

		if not (countingDown or graphics.isFading()) and not (inst:getDuration() > musicTime/1000) and not paused then
			if storyMode and song < 3 then
				if score > highscores[weekNum-1][difficulty].scores[song] then
					highscores[weekNum-1][difficulty].scores[song] = score
					saveHighscores()
				end
				newAccuracy = convertedAcc:gsub("%%", "")
				if tonumber(newAccuracy) > highscores[weekNum-1][difficulty].accuracys[song] then
					print("New accuracy: " .. newAccuracy)
					highscores[weekNum-1][difficulty].accuracys[song] = tonumber(newAccuracy)
					saveHighscores()
				end
				song = song + 1

				self:load()
			else
				status.setLoading(true)

				graphics.fadeOut(
					0.5,
					function()
						Gamestate.switch(menu)

						status.setLoading(false)
					end
				)
			end
		end

		weeks:updateUI(dt)
	end,

	draw = function(self)
		love.graphics.push()
			love.graphics.translate(graphics.getWidth() / 2, graphics.getHeight() / 2)
			love.graphics.scale(extraCamZoom.sizeX, extraCamZoom.sizeY)
			love.graphics.scale(cam.sizeX, cam.sizeY)

			love.graphics.setColor(255, 255, 255, bgFade)

			love.graphics.rectangle("fill", -1000,-700, 9999,9999)

			love.graphics.setColor(1, 1, 1, 1)

			if musicTime <= 73714.2857142858 + 1700 then
				stages["stage"]:draw()

				weeks:drawRating(0.9)
			end
		love.graphics.pop()
		if musicTime <= 73714.2857142858 + 1700 then
		
			weeks:drawTimeLeftBar()
			weeks:drawHealthBar()
			if not paused then
				weeks:drawUI()
			end
		end
	end,

	leave = function(self)
		stages["stage"]:leave()
		weeks:leave()
	end
}
