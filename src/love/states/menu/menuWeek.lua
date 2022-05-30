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










		if weekNum == 1 then
			if weekButtonY[1] == 220 or weekButton[1] == 820 then
				Timer.tween(1, weekButtonY, {[1] = 220, [2] = 320, [3] = 420, [4] = 520, [5] = 620, [7] = 820})
			end
		elseif weekNum == 2 then
			if weekButtonY[1] ~= 320 then
				Timer.tween(1, weekButtonY, {[1] = 320, [2] = 420, [3] = 520, [4] = 620, [5] = 720, [7] = 920})
			end
		elseif weekNum == 3 then
			if weekButtonY[1] ~= 420 then
				Timer.tween(1, weekButtonY, {[1] = 420, [2] = 520, [3] = 620, [4] = 720, [5] = 820, [7] = 920})
			end
		elseif weekNum == 4 then
			if weekButtonY[1] ~= 520 then
				Timer.tween(1, weekButtonY, {[1] = 520, [2] = 620, [3] = 720, [4] = 820, [5] = 920, [7] = 1020})
			end
		elseif weekNum == 5 then
			Timer.tween(1, weekButtonY, {[1] = 620, [2] = 720, [3] = 820, [4] = 920, [5] = 1020, [7] = 1100})
		elseif weekNum == 6 then
			Timer.tween(1, weekButtonY, {[1] = 720, [2] = 820, [3] = 920, [4] = 1020, [5] = 1100, [7] = 1220})
		else 
			Timer.tween(1, weekButtonY, {[1] = 820, [2] = 920, [3] = 1020, [4] = 1100, [5] = 1220, [7] = 1320})
		end




------------------------------------------------------------------------------]]

local upFunc, downFunc, confirmFunc, backFunc, drawFunc, menuFunc, menuDesc, trackNames

local menuState

local menuNum = 1

weekNum = 1
local songNum, songAppend
local songDifficulty = 2

local tutorial, week1, week2, week3, week4, week5, week6

local weekDesc = { -- Add your week description here
	"LEARN TO FUNK",
	"DADDY DEAREST",
	"SPOOKY MONTH",
	"PICO",
	"MOMMY MUST MURDER",
	"RED SNOW",
	"HATING SIMULATOR FT. MOAWLING"
}
local difficultyStrs = { 
	"easy",
	"normal",
	"hard"
}

trackNames = { -- add your songs here
	{
		"\nTutorial"
	},
	{
		"\nBopeebo",
		"\nFresh",
		"\nDad-Battle"
	},
	{
		"\nSpookeez",
		"\nSouth",
		"\nMonster"
	},
	{
		"\nPico",
		"\nPhilly",
		"\nBlammed"
	},
	{
		"\nSatin-Panties",
		"\nHigh",
		"\nM.I.L.F"
	},
	{
		"\nCocoa",
		"\nEggnog",
		"\nWinter-Horrorland"
	},
	{
		"\nSenpai",
		"\nRoses",
		"\nThorns"
	}
}

weekButtonY = {
	[1] = 220,
	[2] = 320,
	[3] = 420,
	[4] = 520,
	[5] = 620,
	[6] = 720,
	[7] = 820
}

local selectSound = love.audio.newSource("sounds/menu/select.ogg", "static")
local confirmSound = love.audio.newSource("sounds/menu/confirm.ogg", "static")

local function switchMenu(menu)

end

return {
	enter = function(self, previous)
		songNum = 0
		weekNum = 1	

		cam.sizeX, cam.sizeY = 0.9, 0.9
		camScale.x, camScale.y = 0.9, 0.9

		if useDiscordRPC then -- Set a custom RPC here
			presence = {
				state = "Choosing A Week",
				details = "In the Week Select Menu",
				largeImageKey = "logo",
				startTimestamp = now,
			}
			nextPresenceUpdate = 0
		end

		freeColour = {
			255,255,255
		}
		freeplayColours = {
			{146,0,68}, -- Tutorial
			{129,100,223}, -- Week 1
			{30,45,60}, -- Week 2
			{131,19,73}, -- Week 3
			{222,132,190}, -- Week 4
			{141,184,225}, -- Week 5
			{225,106,169} -- Week 6
		}
		Timer.tween(
			0.8,
			freeColour, 
			{
				[1] = freeplayColours[1][1],
				[2] = freeplayColours[1][2],
				[3] = freeplayColours[1][3]
			}, 
			"linear"
		)

		
		titleBG = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/weekMenu")))

		enemyDanceLines = love.filesystem.load("sprites/menu/idlelines.lua")()

		difficultyAnim = love.filesystem.load("sprites/menu/difficulty.lua")()

		bfDanceLines = love.filesystem.load("sprites/menu/idlelines.lua")()

		gfDanceLines = love.filesystem.load("sprites/menu/idlelines.lua")()

		enemyDanceLines.x, enemyDanceLines.y = -375, -170
		enemyDanceLines.sizeX, enemyDanceLines.sizeY = 0.5, 0.5

		bfDanceLines.sizeX, bfDanceLines.sizeY = 0.7, 0.7
		gfDanceLines.sizeX, gfDanceLines.sizeY = 0.5, 0.5

		bfDanceLines.x, bfDanceLines.y = 0, -150
		gfDanceLines.x, gfDanceLines.y = 375, -170

		difficultyAnim.x, difficultyAnim.y = 400, 220

		-- Week Images
		-- Just add a new images here
		tutorial = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/week0")))
		week1 = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/week1")))
		week2 = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/week2")))
		week3 = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/week3")))
		week4 = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/week4")))
		week5 = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/week5")))
		week6 = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/week6")))

		weekImages = { -- Images are preloaded
			tutorial,
			week1,
			week2,
			week3,
			week4,
			week5,
			week6
		}

		bfDanceLines:animate("boyfriend", true)
		gfDanceLines:animate("girlfriend", true)
		enemyDanceLines:animate("week1", true)


		---if weekNum ~= 1 then
		---	weekBefore = weekImages[weekNum - 1]
		---	weekBefore.y = 130
		--end
		--weekImages[weekNum].y = 220
		--if weekNum ~= #trackNames then
		--	weekAfter = weekImages[weekNum + 1]
		--	weekAfter.y = 320
		--end

		switchMenu(1)

		graphics.setFade(0)
		graphics.fadeIn(0.5)

		function confirmFunc()
			menu:musicStop()
			songNum = 1

			status.setLoading(true)

			graphics.fadeOut(
				0.5,
				function()
					if useDiscordRPC then
						presence = {
							state = "Selected a week",
							details = "Playing a week",
							largeImageKey = "logo",
							startTimestamp = now,
						}
						nextPresenceUpdate = 0
					end

					if weekNum == 6 then
						week5Playing = true
					else
						week5Playing = false
					end
					if weekNum == 5 then
						doingWeek4 = true
					else
						doingWeek4 = false  -- what
					end
					
					songAppend = difficultyStrs[songDifficulty]

					storyMode = true

					Gamestate.switch(weekData[weekNum], songNum, songAppend, weekNum, trackNames)

					status.setLoading(false)
				end
			)
		end
		
	end,

	update = function(self, dt)



		tutorial.y = weekButtonY[1]
		week1.y = weekButtonY[2]
		week2.y = weekButtonY[3]
		week3.y = weekButtonY[4]
		week4.y = weekButtonY[5]
		week5.y = weekButtonY[6]
		week6.y = weekButtonY[7]


		function menuFunc()
			if weekNum ~= 7 then -- Due to senpais idlelines being smaller than the rest, we resize it
				enemyDanceLines.sizeX, enemyDanceLines.sizeY = 0.5, 0.5
			elseif weekNum == 7 then
				enemyDanceLines.sizeX, enemyDanceLines.sizeY = 1, 1
			end

			weekBefore = weekImages[weekNum - 1]
			weekAfter = weekImages[weekNum + 1]

			--if weekNum ~= 1 then
			--	weekBefore.y = 130
			--end
			--weekImages[weekNum].y = 220
			--if weekNum ~= #trackNames then
			--	weekAfter.y = 320
			--end

			enemyDanceLines:animate("week" .. weekNum, true)
		end
		
		enemyDanceLines:update(dt)
		bfDanceLines:update(dt)
		gfDanceLines:update(dt)

		if songDifficulty == 1 then
			difficultyAnim:animate("easy", true)
		elseif songDifficulty == 2 then
			difficultyAnim:animate("normal", true)
		elseif songDifficulty == 3 then
			difficultyAnim:animate("hard", true)
		end

		difficultyAnim:update(dt)

		if not graphics.isFading() then
			if not music:isPlaying() then
				music:play()
			end
			if input:pressed("down") then
				audio.playSound(selectSound)

				if weekNum ~= #trackNames then -- change 7 to the ammount of weeks there is (tutorial-6)              where tf is this 7 youre talking about
					weekNum = weekNum + 1
					Timer.tween(
						0.1,
						freeColour, 
						{
							[1] = freeplayColours[weekNum][1],
							[2] = freeplayColours[weekNum][2],
							[3] = freeplayColours[weekNum][3]
						}, 
						"linear"
					)
				end
				--else
				--	weekNum = 1
				--end
				menuFunc()
				if weekNum ~= #trackNames then
					Timer.tween(0.2, weekButtonY, { [1] = weekButtonY[1] - 100, [2] = weekButtonY[2] - 100, [3] = weekButtonY[3] - 100, [4] = weekButtonY[4] - 100, [5] = weekButtonY[5] - 100, [6] = weekButtonY[6] - 100, [7] = weekButtonY[7] - 100}, "out-expo")
				end
			elseif input:pressed("up") then
				audio.playSound(selectSound)

				if weekNum ~= 1 then
					weekNum = weekNum - 1
					Timer.tween(
						0.1,
						freeColour, 
						{
							[1] = freeplayColours[weekNum][1],
							[2] = freeplayColours[weekNum][2],
							[3] = freeplayColours[weekNum][3]
						}, 
						"linear"
					)
				end
				--else
				--	weekNum = #trackNames
				--end
				menuFunc()


				if weekNum > 1 then
					Timer.tween(0.2, weekButtonY, { [1] = weekButtonY[1] + 100, [2] = weekButtonY[2] + 100, [3] = weekButtonY[3] + 100, [4] = weekButtonY[4] + 100, [5] = weekButtonY[5] + 100, [6] = weekButtonY[6] + 100, [7] = weekButtonY[7] + 100}, "out-expo")
				end
			elseif input:pressed("left") then
				audio.playSound(selectSound)

				if songDifficulty ~= 1 then
					songDifficulty = songDifficulty - 1
				else
					songDifficulty = 3 
				end

			elseif input:pressed("right") then
				audio.playSound(selectSound)

				if songDifficulty ~= 3 then
					songDifficulty = songDifficulty + 1
				else
					songDifficulty = 1
				end

			elseif input:pressed("confirm") then
				audio.playSound(confirmSound)
                bfDanceLines:animate("boyfriend confirm", false)

				confirmFunc()
			elseif input:pressed("back") then
				audio.playSound(selectSound)

				Gamestate.switch(menuSelect)
			end
		end
		currentWeek = weekImages[weekNum]
	end,

	draw = function(self)
		love.graphics.push()
			love.graphics.translate(graphics.getWidth() / 2, graphics.getHeight() / 2)

			titleBG:draw()

			love.graphics.push()
				love.graphics.scale(cam.sizeX, cam.sizeY)
				tutorial:draw()
				week1:draw()
				week2:draw()
				week3:draw()
				week4:draw()
				week5:draw()
				week6:draw()

				love.graphics.setColor(0, 0, 0)
				
				love.graphics.rectangle("fill", -1000, -351, 2500, -100) 

				love.graphics.setColorF(freeColour[1], freeColour[2], freeColour[3])

				love.graphics.rectangle("fill", -1000, -351, 2500, 411) 

				love.graphics.setColor(1, 1, 1)

				difficultyAnim:draw()
				if weekNum ~= 1 then
					enemyDanceLines:draw()
				end
				bfDanceLines:draw()
				gfDanceLines:draw()
				--if weekNum ~= 1 then
				--	weekBefore:draw()
				--end
				--currentWeek:draw()
				--if weekNum ~= #trackNames then
				--	weekAfter:draw()
				--end


				love.graphics.printf(weekDesc[weekNum], -585, -395, 853, "right", nil, 1.5, 1.5)
				if weekNum ~= 1 then
					love.graphics.color.printf("TRACKS" .. trackNames[weekNum][1] .. trackNames[weekNum][2] .. trackNames[weekNum][3], -1050, 140, 853, "center", nil, 1.5, 1.5, 255, 117, 172)
				else
					love.graphics.color.printf("TRACKS" .. trackNames[weekNum][1], -1050, 140, 853, "center", nil, 1.5, 1.5, 255, 117, 172)
				end

			love.graphics.pop()
		love.graphics.pop()
	end,

	leave = function(self)
		week0 = nil
		week1 = nil
		week2 = nil
		week3 = nil
		week4 = nil
		week5 = nil
		week6 = nil
		enemyDanceLines = nil
		bfDanceLines = nil
		gfDanceLines = nil
		titleBG = nil
		difficultyAnim = nil
		weekImages = nil
		Timer.clear()
	end
}
