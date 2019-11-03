-----------------------------------------------------------------------------------------
--
-- retry.lua
--
-----------------------------------------------------------------------------------------


local composer = require( "composer" )
local scene = composer.newScene()


function scene:create( event )
	local sceneGroup = self.view

	-- display a background image
	local background = display.newImageRect( "purplebackground.png", display.actualContentWidth, display.actualContentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX 
	background.y = 0 + display.screenOriginY
	
	
	-- create a widget button (which will loads level1.lua on release)
	playButton = widget.newButton{
		label="Tap to Play",
		labelColor = { default={255}, over={128} },
		default="button.png",
		over="button-over.png",
		width=1334, height=750,
		onRelease = onplayButtonRelease	-- event listener function
	}
	playButton.x = display.contentCenterX
	playButton.y = display.contentHeight - 190
	
	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	--sceneGroup:insert( titleText )
	sceneGroup:insert( playButton )
end