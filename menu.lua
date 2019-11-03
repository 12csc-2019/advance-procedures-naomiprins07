-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include widget library
local widget = require "widget"



-- 'onRelease' event listener for playButton


function scene:create( event )
	local sceneGroup = self.view

	-- display a background image
	local background = display.newImageRect( "purplebackground.png", display.actualContentWidth, display.actualContentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX 
	background.y = 0 + display.screenOriginY

	local function onplayButtonRelease(event)
	
	-- go to level1.lua scene
	print("tap")
	composer.gotoScene( "level1", "fade", 500 )
	
	return true	-- indicates successful touch
end
	-- create a widget button (which will loads level1.lua on release)
	local playButton = widget.newButton{
		label="Tap to Play",
		labelColor = { default={255}, over={128} },
		default="button.png",
		over="button-over.png",
		width=1334, height=750,
		onRelease = onplayButtonRelease	-- event listener function
	}
	playButton.x = display.contentCenterX
	playButton.y = display.contentHeight - 190
	
	sceneGroup:insert( background )
	sceneGroup:insert( playButton )
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
	elseif phase == "did" then
			local previousScene = composer.getSceneName( "previous" )
		if(previousScene~=nil) then
		      composer.removeScene(previousScene)
		      print("PREVIOUS SCENE REMOVED: " .. previousScene)
		     end 
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
	elseif phase == "did" then
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- if playButton then
	-- 	playButton:removeSelf()	
	-- 	playButton = nil
	-- end
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene