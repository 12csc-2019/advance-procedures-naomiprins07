-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

-- include widget library
local widget = require "widget"
local composer = require( "composer" )
local scene = composer.newScene()

-- include physics library
local physics = require "physics"

--------------------------------------------

function scene:create(event)

	local sceneGroup = self.view

	-- Start physics
	physics.start()
	physics.pause()


	-- Display background
	local background = display.newImageRect("purplebackground.png", display.actualContentWidth, display.actualContentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX 
	background.y = 0 + display.screenOriginY
	
	-- Display obstacle
	local obstacleOne = display.newRect( 250, 300, 100, 220)
	obstacleOne.strokeWidth = 1
	obstacleOne:setFillColor(0.2, 0, 0.5)
	obstacleOne:setStrokeColor(0.2, 0, 0.5)

	-- Position character on screen
	local character = display.newImage("dragonfly.png")
	character.x = 50
	character.y = 150
	character:scale(0.07, 0.07)
	character:scale(-1, 1)

	-- Create function for when obstacle is hit 
	local function retry(event)

	
	-- Create button size of screen
	local tapButton

	-- function to handle button press
	local function handleTapButtonEvent(event)
		if event.target.id == "tap" then
				-- update the x and y values
			character.x = character.x + 50
			character.y = character.y - 50
			--if character.x < 250 and character.x > 350 then
				-- go to level1.lua scene
			--	composer.gotoScene( "retry", "fade", 500 )
			--	return true	-- indicates successful touch
			--end
		end
	end


	tapButton = widget.newButton{
		id = "tap",
		width=1334, height=750,
		onRelease = handleTapButtonEvent	
	}

	-- Add physics to character
	physics.addBody( character, "dynamic" )
	character.gravityScale = 0.25

	
	-- Insert screen graphics into group
	sceneGroup:insert( background )
	sceneGroup:insert( character )
end


function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		physics.start()
	end
end




function scene:hide(event)
	local sceneGroup = self.view
	
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		physics.stop()
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
	
end

function scene:destroy(event)

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view
	
	package.loaded[physics] = nil
	physics = nil
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene