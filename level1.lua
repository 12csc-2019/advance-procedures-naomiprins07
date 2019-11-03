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
physics.setDrawMode( "hybrid" )
physics.start()

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
	sceneGroup:insert(background)
	
	-- Display obstacle
	local obstacleOne = display.newRect( display.contentWidth, 300, 70, 220)
	obstacleOne.strokeWidth = 1
	obstacleOne:setFillColor(0.2, 0, 0.5)
	obstacleOne:setStrokeColor(0.2, 0, 0.5)
	obstacleOne.name = "obstacleOne"
	sceneGroup:insert(obstacleOne)

-- Display obstacle
	local obstacleTwo = display.newRect( display.contentWidth, 1, 70, 100)
	obstacleTwo.strokeWidth = 1
	obstacleTwo:setFillColor(0.2, 0, 0.5)
	obstacleTwo:setStrokeColor(0.2, 0, 0.5)
	obstacleTwo.name = "obstacleTwo"
	sceneGroup:insert(obstacleTwo)

	-- Position character on screen
	local character = display.newImage("dragonflyScale.png")
	character.x = 50
	character.y = 150
	character:scale(-1, 1)
	character.name = "character"
	sceneGroup:insert(character)
	physics.addBody( character, "dynamic" )
	physics.addBody(obstacleOne, "static")
	physics.addBody(obstacleTwo, "static")

	local function onCollision(self, event)
		print("here", event.phase)
		if event.phase == "began" then
			timer.performWithDelay(1, function()
				physics.stop()
				composer.gotoScene( "menu" )
			end)
		end
	end

	character.collision = onCollision
	character:addEventListener( "collision", character )

	local function rt (self)
		if not obstacleOne or obstacleOne.removeSelf == nil then
			Runtime:removeEventListener("enterFrame", rt)
			print('dfsdfs')
			return true
		end
		obstacleOne.x =  obstacleOne.x - 6
		if obstacleOne.x  < 0 then
			obstacleOne.x = display.contentWidth	
		end
		obstacleTwo.x =  obstacleTwo.x - 6
		if obstacleTwo.x  < 0 then
			obstacleTwo.x = display.contentWidth	
		end
	end

	Runtime:addEventListener("enterFrame", rt)

	-- function to handle button press
	local function handleTapButtonEvent(event)

		if not character or character.applyForce == nil then return true end
		if event.target.id == "tap" then
			character:applyForce( 0, -7, character.x, character.y )
		end
	end

	-- Create button size of screen
	local tapButton tapButton = widget.newButton{
		id = "tap",
		width=1334, height=750,
		onRelease = handleTapButtonEvent	
	}


	character.gravityScale = 0.5
	
	-- Insert screen graphics into group
	sceneGroup:insert( background )
	sceneGroup:insert( character )
	sceneGroup:insert( obstacleOne )
	sceneGroup:insert( obstacleTwo )

end

function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		physics.start()
		local previousScene = composer.getSceneName( "previous" )
		if(previousScene~=nil) then
		      composer.removeScene(previousScene)
		      print("PREVIOUS SCENE REMOVED: " .. previousScene)
		     end 
	end
end

function scene:hide(event)
	local sceneGroup = self.view
	local phase = event.phase
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--physics.stop()
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end		
end

function scene:destroy(event)
	local sceneGroup = self.view

end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
