-----------------------------------------------------------------------------------------
--
-- chapterselection
--
-----------------------------------------------------------------------------------------

local scene = storyboard.newScene()
local chapters

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

    game.level = 0
    game.scene = self.view

    ---------------------------------------------------------------

    viewManager.initBack(0)

    ---------------------------------------------------------------

    viewManager.buildEffectButton(
        game.hud,
        "assets/images/hud/back.png",
        51, 
        0.18*aspectRatio,
        display.contentWidth*0.1, 
        display.contentHeight*0.1, 
        function()
            if(viewManager.closeWebView) then
                viewManager.closeWebView()
                viewManager.closeWebView = nil
            else 
                router.openAppHome()
            end
        end
    )

    ---------------------------------------------------------------

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

    -----------------------------------------------------

    self:createChapterContent(1, display.contentWidth*0.33, display.contentHeight*0.25, false)
    self:createFacebookChapter(2, display.contentWidth*0.33, display.contentHeight*0.6, 2000)

    --    self:createChapterContent(2, display.contentWidth*0.1, display.contentHeight*0.55, (not DEV) and (not GLOBALS.savedData.chapters[1].complete or not GLOBALS.savedData.fullGame))
    --    self:createChapterContent(3, display.contentWidth*0.54, display.contentHeight*0.63, (not DEV) and (not GLOBALS.savedData.chapters[2].complete or not GLOBALS.savedData.fullGame))

end

-----------------------------------------------------------------------------------------

function scene:createFacebookChapter(chapter, x, y, requiredLikes)

    ------------------

    local widget = display.newGroup()
    game.hud:insert(widget)
    widget.x = x
    widget.y = y
    widget.contentWidth = display.contentWidth*0.33
    widget.contentHeight = display.contentHeight*0.3
    widget.alpha = 0

    utils.onTouch(widget,  function(event) 
        viewManager.closeWebView = viewManager.openWeb("http://facebook.com/uralys")
    end)

    ------------------

    local box = display.newRoundedRect(widget, 0, 0, widget.contentWidth, widget.contentHeight, 10)
    box.x = widget.contentWidth/2
    box.y = widget.contentHeight/2
    box.alpha = 0.3
    box:setFillColor(0)

    if(not locked) then
        box.alpha = 0.4
    end

    ------------------

    local chapterTitle = display.newText( {
        parent = widget,
        text = CHAPTERS[chapter].title,     
        x = widget.contentWidth*0.95,
        y = 25,
        width = display.contentWidth*0.6,    
        font = FONT,   
        fontSize = 40,
        align = "right"
    })
    
    chapterTitle.anchorX = 1

    ------------------

    local fb = display.newImage( widget, "assets/images/others/facebook.png")  
    fb.x = widget.contentWidth * 0.13
    fb.y = widget.contentHeight* 0.43
    
    ---------------------------------------------------------------
    
    if(GLOBALS.facebookLikes > 0) then
        utils.drawPercentageBar(
            widget, 
            GLOBALS.facebookLikes/requiredLikes, 
            widget.contentWidth   * 0.6,
            widget.contentHeight  * 0.43,
            widget.contentWidth   * 0.65, 
            display.contentHeight * 0.1
        )
    
        local likesText = display.newText( {
            parent      = widget,
            text        = GLOBALS.facebookLikes .. " / " .. requiredLikes,
            x           = widget.contentWidth*0.36,
            y           = widget.contentHeight*0.43,
            font        = FONT,   
            fontSize    = 37,
            align       = "center"
        })
        
        likesText.anchorX = 0
        likesText.anchorY = 0.6
    
        local likesText = display.newText( {
            parent      = widget,
            text        = T "Unlock this chapter !",
            x           = widget.contentWidth*0.5,
            y           = widget.contentHeight*0.7,
            font        = FONT,   
            fontSize    = 30,
            align       = "center"
        })

        local likesText = display.newText( {
            parent      = widget,
            text        = "(".. (requiredLikes - GLOBALS.facebookLikes) ..T " FB likes remaining" .. ")",
            x           = widget.contentWidth*0.5,
            y           = widget.contentHeight*0.86,
            font        = FONT,   
            fontSize    = 30,
            align       = "center"
        })
    else
    
        local noConnectionText = display.newText( {
            parent      = widget,
            text        = T "Locked. Check your internet connection to see FB likes.",     
            x           = widget.contentWidth*0.65,
            y           = widget.contentHeight*0.55,
            width       = widget.contentWidth*0.7,    
            font        = FONT,   
            fontSize    = 30,
            align       = "center"
        })
    end
    
    ------------------

    transition.to( widget, { time=500, alpha=1 })

    widget:toFront()
end

-----------------------------------------------------------------------------------------

function scene:createChapterContent(chapter, x, y, locked)

    ------------------

    local widget = display.newGroup()
    game.hud:insert(widget)
    widget.x = x
    widget.y = y
    widget.contentWidth = display.contentWidth*0.33
    widget.contentHeight = display.contentHeight*0.3
    widget.alpha = 0

    if(not locked) then
        utils.onTouch(widget, function() 
            openChapter(chapter) 
        end)
    end

    ------------------

    local box = display.newRoundedRect(widget, 0, 0, widget.contentWidth, widget.contentHeight, 10)
    box.x = widget.contentWidth/2
    box.y = widget.contentHeight/2
    box.alpha = 0.3
    box:setFillColor(0)

    if(not locked) then
        box.alpha = 0.4
    end

    ------------------

    viewManager.buildEffectButton(
        game.hud,
        chapter,
        51, 
        0.67,
        x+display.contentWidth*0.2, 
        y+display.contentHeight*0.145, 
        function() 
            openChapter(chapter) 
        end, 
        locked
    )

    ------------------

    local chapterTitle = display.newText( {
        parent = widget,
        text = CHAPTERS[chapter].title,     
        x = widget.contentWidth*0.95,
        y = widget.contentHeight*0.12,
        width = display.contentWidth*0.3,    
        font = FONT,   
        fontSize = 40,
        align = "right"
    } )
    
    chapterTitle.anchorX = 1

    ------------------

    local energies = display.newImage( widget, "assets/images/hud/energy.png")
    energies.x = 25
    energies.y = widget.contentHeight*0.4
    energies:scale(0.5,0.5)

    local energiesCaught  = 0
    local energiesToCatch = 0

    for i=1,CHAPTERS[chapter].nbLevels do
        energiesCaught      = energiesCaught + GLOBALS.savedData.chapters[chapter].levels[i].score.energiesCaught 
        energiesToCatch     = energiesToCatch + #CHAPTERS[chapter].levels[i].energies 
    end

    local energiesText = display.newText( {
        parent = widget,
        text = energiesCaught .. "/" .. energiesToCatch,     
        x = 110,
        y = widget.contentHeight*0.4,
        font = FONT,   
        fontSize = 36,
        align = "left"
    } )
    
    energiesText.anchorX     = 0.4
    energiesText.anchorY     = 0.6
    energiesText:setFillColor( 255 )    

    ------------------

    local piecesCaught  = 0
    local piecesToCatch = CHAPTERS[chapter].nbLevels

    for i=1,CHAPTERS[chapter].nbLevels do
        piecesCaught     = piecesCaught + GLOBALS.savedData.chapters[chapter].levels[i].score.piecesCaught 
    end

    local piece = display.newSprite( widget, levelDrawer.pieceImageSheet, levelDrawer.pieceSheetConfig:newSequence() )
    piece.x             = 25
    piece.y             = widget.contentHeight*0.6
    if(piecesCaught > 0) then
        piece:play()
    else
        piece.alpha = 0.2
    end

    local piecesText = display.newText( {
        parent = widget,
        text = piecesCaught .. "/" .. piecesToCatch,     
        x = 110,
        y = widget.contentHeight*0.6,
        width = 100, 
        font = FONT,   
        fontSize = 33,
        align = "left"
    } )

    ------------------

    local ringsCaught  = 0
    local ringsToCatch = CHAPTERS[chapter].nbLevels

    for i=1,CHAPTERS[chapter].nbLevels do
        ringsCaught     = ringsCaught + GLOBALS.savedData.chapters[chapter].levels[i].score.ringsCaught 
    end

    local ring = display.newSprite( widget, levelDrawer.simplePieceImageSheet, levelDrawer.pieceSheetConfig:newSequence() )
    ring.x         = 25
    ring.y         = widget.contentHeight*0.8
    if(ringsCaught > 0) then
        ring:play()
    else
        ring.alpha = 0.2
    end

    local ringsText = display.newText( {
        parent = widget,
        text = ringsCaught .. "/" .. ringsToCatch,     
        x = 110,
        y = widget.contentHeight*0.8,
        width = 100, 
        font = FONT,   
        fontSize = 33,
        align = "left"
    } )


    ------------------

    local points = 0

    for i=1,CHAPTERS[chapter].nbLevels do
        points     = points + GLOBALS.savedData.chapters[chapter].levels[i].score.points 
    end


    if(points > 0) then

        local pointsText = display.newText( {
            parent = widget,
            text = points .. " pts",     
            x = widget.contentWidth - 10,
            y = widget.contentHeight*0.8,
            font = FONT,   
            fontSize = 38,
            align = "right"
        } )

        pointsText.anchorX = 1
    end

    ------------------

    local percent = math.floor(100* ((0.5)*(energiesCaught/energiesToCatch) + (0.25)*(ringsCaught/ringsToCatch) + (0.25)*(piecesCaught/piecesToCatch)))

    local percentText = display.newText( {
        parent = widget,
        text = percent .. " %",     
        x = widget.contentWidth*0.94,
        y = widget.contentHeight*0.3,
        font = FONT,   
        fontSize = 35,
    } )
    
    percentText.anchorX = 1

    ------------------

    if(locked) then
        transition.to( widget, { time=500, alpha=0.4 })
    else
        transition.to( widget, { time=500, alpha=1 })
    end

    widget:toFront()
end


------------------------------------------

function openChapter( chapter )
    musicManager:playGrab()
    game.chapter = chapter
    viewManager.initBack(chapter)
    router.openLevelSelection()
end

------------------------------------------

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    self:refreshScene();
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