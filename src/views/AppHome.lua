-----------------------------------------------------------------------------------------
--
-- AppHome.lua
--
-----------------------------------------------------------------------------------------

local scene = storyboard.newScene()

-----------------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
-- 
-- NOTE: Code outside of listener functions (below) will only be executed once,
--         unless storyboard.removeScene() is called.
-- 
-----------------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
end

-----------------------------------------------------------------------------------------

function scene:refreshScene()

    viewManager.initBack(0)
    
    ---------------------------------------------------------------
    -- tests
    
    game.hud.title = display.newImage( game.hud, "assets/images/hud/title.png" )
    game.hud.title.x = display.contentWidth*0.7
    game.hud.title.y = display.contentHeight*0.1
    game.hud.title:scale(0.38,0.38)
    
    effectsManager.atmosphere(display.contentWidth*0.7 - game.hud.title.contentWidth/2 + 20, 115, 0.76)
    effectsManager.atmosphere(display.contentWidth*0.8, 120, 0.9)

    game.hud.subtitle = display.newText( game.hud, "...there is Magic" , 0, 0, FONT, 25 )
    game.hud.subtitle:setFillColor( 255 )    
    game.hud.subtitle.x = display.contentWidth*0.86
    game.hud.subtitle.y = display.contentHeight*0.16
    
    ---------------------------------------------------------------

    viewManager.buildEffectButton(
        game.hud,
        "assets/images/hud/play.black.png", 
        21, 
        0.66*aspectRatio,
        display.contentWidth*0.5,     
        display.contentHeight*0.5,     
        function()
            if(GLOBALS.savedData.requireTutorial) then
                game.chapter     = 1
                game.level         = 1
                router.openPlayground()
            else
                router.openChapterSelection()
           end
        end
    )

    ---------------------------------------------------------------
    
    local scale = 0.23*aspectRatio
    
    viewManager.buildEffectButton(
        game.hud,
        "assets/images/hud/settings.png", 
        0,
        scale,
        display.contentWidth * 0.06, 
        display.contentHeight * 0.93, 
        function() 
            router:openOptions() 
        end
    )

    ---------------------------------------------------------------
--    
--    if(not GLOBALS.savedData.fullGame) then    
--       viewManager.buildEffectButton(
--           game.hud,
--           "assets/images/hud/lock.png", 
--           0,
--           scale,
--           display.contentWidth * 0.15, 
--           display.contentHeight * 0.93,
--           function() 
--               router:openBuy() 
--           end
--       )
--    end

    ---------------------------------------------------------------
    
--   if(IOS) then
--       timer.performWithDelay(600, gameCenter.init)
--   end
   
end

------------------------------------------

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    self:refreshScene()
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
end

-----------------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
-----------------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched whenever before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

-----------------------------------------------------------------------------------------

return scene