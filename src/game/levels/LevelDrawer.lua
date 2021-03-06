-------------------------------------

module(..., package.seeall)

-------------------------------------
-- SHEETS

TILES                     = 1
TREES                     = 2
TILES_GREY                 = 3
TILES_DARK                 = 4
LEVEL_MISC                 = 5

PIECE                     = 6 -- SAME NUM FOR MISC
SIMPLE_PIECE             = 7 -- SAME NUM FOR MISC

TILES_CLASSIC             = 8
TILES_GREEN             = 9
PLANTS                     = 10

LEVEL_HUGE_CLASSIC     = 11
LEVEL_HUGE_GREEN         = 12
LEVEL_HUGE_GREY         = 13
LEVEL_HUGE_SOBER         = 14

IVY                         = 15
IVY_MINI                 = 16

---------------
-- LEVEL MISC

BAD                 = 1 
CHECKPOINT         = 2 
SPAWNPOINT         = 3 
EXIT                 = 4
PANEL                = 5 
--PIECE             = 6
--SIMPLE_PIECE = 7
MINI_EYE            = 8

-------------------------------------

tilesSheetConfig                 = require("src.game.graphics.Tiles")
treesSheetConfig                 = require("src.game.graphics.Trees")
levelMiscSheetConfig         = require("src.game.graphics.LevelMisc")
pieceSheetConfig                 = require("src.game.graphics.Piece")
plantsSheetConfig             = require("src.game.graphics.Plants")
levelHugeSheetConfig         = require("src.game.graphics.LevelHuge")
ivySheetConfig                 = require("src.game.graphics.Ivy")
ivyMiniSheetConfig             = require("src.game.graphics.IvyMini")

tilesImageSheet                 = graphics.newImageSheet( "assets/images/game/tiles.png"                    , tilesSheetConfig.sheet )
tilesGreyImageSheet             = graphics.newImageSheet( "assets/images/game/tiles.grey.png"            , tilesSheetConfig.sheet )
tilesDarkImageSheet             = graphics.newImageSheet( "assets/images/game/tiles.dark.png"            , tilesSheetConfig.sheet )
tilesClassicImageSheet         = graphics.newImageSheet( "assets/images/game/tiles.classic.png"        , tilesSheetConfig.sheet )
tilesGreenImageSheet         = graphics.newImageSheet( "assets/images/game/tiles.greenish.png"        , tilesSheetConfig.sheet )
treesImageSheet                 = graphics.newImageSheet( "assets/images/game/Trees.png"                    , treesSheetConfig.sheet )
levelMiscImageSheet             = graphics.newImageSheet( "assets/images/game/LevelMisc.png"            , levelMiscSheetConfig.sheet )
pieceImageSheet                 = graphics.newImageSheet( "assets/images/game/Piece.png"                    , pieceSheetConfig.sheet )
simplePieceImageSheet        = graphics.newImageSheet( "assets/images/game/SimplePiece.png"            , pieceSheetConfig.sheet )
plantsImageSheet                 = graphics.newImageSheet( "assets/images/game/Plants.png"                , plantsSheetConfig.sheet )
levelHugeImageSheet             = graphics.newImageSheet( "assets/images/game/LevelHuge.png"            , levelHugeSheetConfig.sheet )
levelHugeGreenImageSheet    = graphics.newImageSheet( "assets/images/game/LevelHuge-green.png"    , levelHugeSheetConfig.sheet )
levelHugeGreyImageSheet     = graphics.newImageSheet( "assets/images/game/LevelHuge-grey.png"        , levelHugeSheetConfig.sheet )
levelHugeSoberImageSheet    = graphics.newImageSheet( "assets/images/game/LevelHuge-sober.png"    , levelHugeSheetConfig.sheet )
ivyImageSheet                    = graphics.newImageSheet( "assets/images/game/Ivy.png"                    , ivySheetConfig.sheet )
ivyMiniImageSheet                = graphics.newImageSheet( "assets/images/game/IvyMini.png"                , ivyMiniSheetConfig.sheet )

-------------------------------------

sheetConfigs = {}
sheetConfigs[TILES]                         = tilesSheetConfig
sheetConfigs[TREES]                         = treesSheetConfig
sheetConfigs[TILES_GREY]                 = tilesSheetConfig
sheetConfigs[TILES_DARK]                 = tilesSheetConfig
sheetConfigs[LEVEL_MISC]                 = levelMiscSheetConfig
sheetConfigs[PIECE]                         = pieceSheetConfig
sheetConfigs[SIMPLE_PIECE]             = pieceSheetConfig
sheetConfigs[TILES_CLASSIC]             = tilesSheetConfig
sheetConfigs[TILES_GREEN]                 = tilesSheetConfig
sheetConfigs[PLANTS]                     = plantsSheetConfig
sheetConfigs[LEVEL_HUGE_CLASSIC]     = levelHugeSheetConfig
sheetConfigs[LEVEL_HUGE_GREEN]         = levelHugeSheetConfig
sheetConfigs[LEVEL_HUGE_GREY]         = levelHugeSheetConfig
sheetConfigs[LEVEL_HUGE_SOBER]         = levelHugeSheetConfig
sheetConfigs[IVY]                         = ivySheetConfig
sheetConfigs[IVY_MINI]                     = ivyMiniSheetConfig

imageSheets = {}
imageSheets[TILES]                         = tilesImageSheet
imageSheets[TREES]                         = treesImageSheet
imageSheets[TILES_GREY]                 = tilesGreyImageSheet
imageSheets[TILES_DARK]                 = tilesDarkImageSheet
imageSheets[LEVEL_MISC]                 = levelMiscImageSheet
imageSheets[PIECE]                         = pieceImageSheet
imageSheets[SIMPLE_PIECE]                  = simplePieceImageSheet
imageSheets[TILES_CLASSIC]             = tilesClassicImageSheet
imageSheets[TILES_GREEN]                 = tilesGreenImageSheet
imageSheets[PLANTS]                         = plantsImageSheet
imageSheets[LEVEL_HUGE_CLASSIC]         = levelHugeImageSheet
imageSheets[LEVEL_HUGE_GREEN]         = levelHugeGreenImageSheet
imageSheets[LEVEL_HUGE_GREY]             = levelHugeGreyImageSheet
imageSheets[LEVEL_HUGE_SOBER]         = levelHugeSoberImageSheet
imageSheets[IVY]                             = ivyImageSheet
imageSheets[IVY_MINI]                     = ivyMiniImageSheet

level = {}

-------------------------------------

local MOTION_SPEED = 60
local smallShape                 = {  -17,-17, 17,-17, 17,0, -17,0}
local rightTriangleShape     = {  -17,-17, 17,17, -17,17 }
local leftTriangleShape     = {  17,-17, 17,17, -17,17 }

-------------------------------------

function designLevel()

    ---------------------

    level                     = {}
    level.triggers         = {}
    level.enemies             = {}
    level.num                 = game.level
    level.bottomY             = -100000

    ---------------------

    level.content             = CHAPTERS[game.chapter].levels[game.level]

    ---------------------

    local tiles             = level.content.tiles
    local energies         = level.content.energies
    local groupMotions     = level.content.groupMotions
    local groupDragLines = level.content.groupDragLines

    ---------------------

    local groups = {}

    for i=1, #tiles do

        --------------------

        local tile             = drawTile( game.camera, tiles[i].sheet, tiles[i].num, tiles[i].x, tiles[i].y )
        tile.num             = tiles[i].num
        tile.sheet             = tiles[i].sheet
        tile.group             = tiles[i].group
        tile.movable         = tiles[i].movable
        tile.draggable     = tiles[i].draggable
        tile.destructible = tiles[i].destructible
        tile.background    = tiles[i].background
        tile.foreground     = tiles[i].foreground
        tile.trigger         = tiles[i].trigger
        tile.pack            = tiles[i].pack

        tile.startX         = tiles[i].x
        tile.startY         = tiles[i].y
        tile.isFloor         = (not tile.background) and (not tile.foreground)

        local type             = "static"
        local requireBody = tile.isFloor

        --------------------

        if(tile.destructible) then    
            type = "dynamic"     
        end

        if(requireBody) then
            if(isSmallShape(tile)) then
                physics.addBody( tile, type, { density="450", friction=0.3, bounce=0, shape = smallShape } )
                tile.isFixedRotation = true
            elseif(isRightTriangleShape(tile)) then
                physics.addBody( tile, type, { density="450", friction=0.3, bounce=0, shape = rightTriangleShape } )
                tile.isFixedRotation = true
            elseif(isLeftTriangleShape(tile)) then
                physics.addBody( tile, type, { density="450", friction=0.3, bounce=0, shape = leftTriangleShape } )
                tile.isFixedRotation = true
            else
                physics.addBody( tile, type, { density="450", friction=0.3, bounce=0 } )
                tile.isFixedRotation = true
            end

            -- TILE ROTATION ON CENTER
            -- TODO : floor pas par rapport au x,y du floor, mais par rapport au fait que le x,y de la collision est "aux pieds" du character
            -- TODO : jump vx,vy * sinus(rad(rotation))
            -- TODO : on rope Attach :  physics.newJoint( "pivot", attach, floor, collision.x, collision.y)
            --            elseif(tiles[i].num == 2 and (tiles[i].sheet == LEVEL_HUGE_CLASSIC or tiles[i].sheet == LEVEL_HUGE_SOBER or tiles[i].sheet == LEVEL_HUGE_GREY or tiles[i].sheet == LEVEL_HUGE_GREEN  )) then
            --                local circle = display.newCircle(game.camera, tiles[i].x, tiles[i].y, 17)
            --                circle.alpha = 0
            --              physics.addBody( circle, "static", { radius = 17 } )
            --              physics.addBody( tile, "dynamic", { density="10", friction=0.3, bounce=0 } )
            --              physics.newJoint( "pivot", circle, tile, circle.x, circle.y )

        end

        --------------------

        if(tile.startY + 400 > level.bottomY) then
            level.bottomY = tile.startY + 400
        end

        --------------------

        if(tile.group) then
            if(not groups[tile.group]) then
                groups[tile.group] = {}
            end

            groups[tile.group][#groups[tile.group] + 1] = tile
        end


        --------------------
        -- init Triggers

        if(tile.trigger and not level.triggers[tile.trigger]) then
            level.triggers[tile.trigger] = {
                remaining = 0,
                lockX = tile.x,
                lockY = tile.y,
            }
        end        

        --------------------
        --
        -- Grabbable
        -- 
        
        if(mayBeGrabbable(tile)) then
            tile.mayBeGrabbable = true
            
            local setGrabbable = function()
                tile.grabbable = true
                tile.touchArea = display.newCircle( game.camera, tile.x, tile.y, 65 );
                tile.touchArea.isHitTestable    = true
                tile.touchArea.alpha            = 0.15
                tile.touchArea.isVisible        = DEV
                
                tile.touchArea:addEventListener( "touch", function(event)
                    touchController.touchTile(tile, event)
                end)
            end

            if(tile.trigger) then 

                tile.icons = {}
                tile.icons["lock"] = display.newImage(game.camera, "assets/images/hud/lock.png")
                tile.icons["lock"]:scale(0.2,0.2)
                tile.icons["lock"].x = tile.x
                tile.icons["lock"].y = tile.y
                tile.icons["lock"].alpha = 1

                addTriggerStarter(tile.trigger, function()
                    setGrabbable(tile)
                    display.remove(tile.icons["lock"])
                end)
            else
                setGrabbable(tile)
            end
        end

        --------------------
        -- Triggers

        if(tile.trigger and not tile.mayBeGrabbable) then
            level.triggers[tile.trigger].remaining = level.triggers[tile.trigger].remaining + 1
            effectsManager.drawTrigger(tile.x, tile.y, tile.trigger)
            display.remove(tile)
        end

        --------------------
        -- Level Misc 
        -- 

        if(tile.sheet == LEVEL_MISC) then

            if(tile.num == PANEL) then
                tile.panelNum = tiles[i].panelNum
                tile:addEventListener( "touch", openPanel)

            elseif(tile.num == BAD) then
                display.remove(tile)
                local eye = eye:new()
                eye:init(tile.x,tile.y)
                level.enemies[#level.enemies + 1] = eye

            elseif(tile.num == MINI_EYE) then
                display.remove(tile)
                local eye = eye:new()
                eye:miniEye(tile.x,tile.y)
                level.enemies[#level.enemies + 1] = eye

            elseif(tile.num == SPAWNPOINT) then
                level.spawnX = tile.x
                level.spawnY = tile.y
                display.remove(tile)

            elseif(tile.num == CHECKPOINT) then
                local checkPoint = {}
                checkPoint.x = tile.x
                checkPoint.y = tile.y
                display.remove(tile)
                physicsManager.drawCheckpoint(checkPoint)

            elseif(tile.num == EXIT) then
                effectsManager.drawExit(tile.x, tile.y)
                display.remove(tile)

            elseif(tile.num == PIECE) then
                display.remove(tile)
                local piece = display.newSprite( game.camera, pieceImageSheet, pieceSheetConfig:newSequence() )
                piece.x             = tiles[i].x
                piece.y             = tiles[i].y
                piece.type         = tile.num
                piece:play()
                effectsManager.lightPiece(piece)

            elseif(tile.num == SIMPLE_PIECE) then
                display.remove(tile)
                local piece = display.newSprite( game.camera, simplePieceImageSheet, pieceSheetConfig:newSequence() )
                piece.x             = tiles[i].x
                piece.y             = tiles[i].y
                piece.type         = tile.num
                piece:play()
                effectsManager.lightPiece(piece)
            end
        end

        --------------------

        -- listener pour les floors, pas les grabbables, qui ont leur listener sur touchArea eux
        if(tile and tile.isFloor and not tile.mayBeGrabbable) then
            tile:addEventListener( "touch", function(event)
                touchController.touchTile(tile, event)
            end)    
        end
    end 

    ------------------------------

    for i=1, #energies do
        effectsManager.drawEnergy(energies[i].x, energies[i].y, energies[i].type)
    end 

    ------------------------------

    for k,groupMotion in pairs(groupMotions) do
        -- k est parfois le num en string dans le json groupMotions (gd num de groupe a priori)
        if(type(k) == "string") then k = tonumber(k) end

        -- attention @leveldesigner ! pour choisir celle du milieu, il faut que le nbre de tiles dans un groupe draggable soit impair
        local tileWithIcon = groups[k][(#groups[k] + 1)/2]
        if(not tileWithIcon.icons) then tileWithIcon.icons = {} end

        if(groupMotion) then
            -- corona crash sans le performWithDelay ?
            local startMotion = function() timer.performWithDelay(1, function ()

                    if(tileWithIcon.icons["lock"]) then
                        display.remove(tileWithIcon.icons["lock"]) 
                    end 

                    addGroupMotion(groups[k], groupMotion) 
            end) end

            if(groupMotion.trigger) then
                addTriggerStarter(groupMotion.trigger, startMotion)

                -- test car un grababble movable avec trigger aurait 2 locks : bug lors du remove
                if(not tileWithIcon.icons["lock"]) then
                    tileWithIcon.icons["lock"] = display.newImage(game.camera, "assets/images/hud/lock.png")
                    tileWithIcon.icons["lock"]:scale(0.2,0.2)
                    tileWithIcon.icons["lock"].x = tileWithIcon.x
                    tileWithIcon.icons["lock"].y = tileWithIcon.y
                    tileWithIcon.icons["lock"].alpha = 1
                end
            else
                startMotion()
            end

        end
    end

    ------------------------------

    for k,groupDragLine in pairs(groupDragLines) do
        -- k est parfois le num en string dans le json groupMotions (gd num de groupe a priori)
        if(type(k) == "string") then k = tonumber(k) end

        if(groupDragLine) then

            -- attention @leveldesigner ! pour choisir celle du milieu, il faut que le nbre de tiles dans un groupe draggable soit impair
            local tileWithIcon = groups[k][(#groups[k] + 1)/2]
            if(not tileWithIcon.icons) then tileWithIcon.icons = {} end

            tileWithIcon.icons["draggable"] = display.newImage(game.camera, "assets/images/hud/touch.png")
            tileWithIcon.icons["draggable"]:scale(0.2,0.2)
            tileWithIcon.icons["draggable"].x = tileWithIcon.x
            tileWithIcon.icons["draggable"].y = tileWithIcon.y
            tileWithIcon.icons["draggable"].alpha = 0.4

            if(groupDragLine.x2 ~= groupDragLine.x1) then
                tileWithIcon.icons["leftright"] = display.newImage(game.camera, "assets/images/hud/leftright.png")
                tileWithIcon.icons["leftright"]:scale(0.4,0.4)
                tileWithIcon.icons["leftright"].x = tileWithIcon.x
                tileWithIcon.icons["leftright"].y = tileWithIcon.y
                tileWithIcon.icons["leftright"].alpha = 0.4
            end

            if(groupDragLine.y2 ~= groupDragLine.y1) then
                tileWithIcon.icons["updown"] = display.newImage(game.camera, "assets/images/hud/updown.png")
                tileWithIcon.icons["updown"]:scale(0.36,0.36)
                tileWithIcon.icons["updown"].x = tileWithIcon.x
                tileWithIcon.icons["updown"].y = tileWithIcon.y
                tileWithIcon.icons["updown"].alpha = 0.4
            end

            local enableDrag = function() 
                addGroupDraggable(groups[k], groupDragLine)
                if(tileWithIcon.icons["lock"]) then
                    display.remove(tileWithIcon.icons["lock"]) 
                end 
            end

            if(groupDragLine.trigger) then

                tileWithIcon.icons["lock"] = display.newImage(game.camera, "assets/images/hud/lock.png")
                tileWithIcon.icons["lock"]:scale(0.2,0.2)
                tileWithIcon.icons["lock"].x = tileWithIcon.x
                tileWithIcon.icons["lock"].y = tileWithIcon.y
                tileWithIcon.icons["lock"].alpha = 1

                addTriggerStarter(groupDragLine.trigger, enableDrag)
            else
                enableDrag()
            end
        end
    end

    -----------------------------
    -- to access groups elsewhere
    level.groups = groups
end

-------------------------------------

function isRealTile(tile)
    return tile.sheet == TILES
        or  tile.sheet == TILES_CLASSIC
        or  tile.sheet == TILES_GREEN
        or  tile.sheet == TILES_GREY
        or  tile.sheet == TILES_DARK
end

-------------------------------------

function isHugeTile(tile)
    return tile.sheet == LEVEL_HUGE_GREEN
        or  tile.sheet == LEVEL_HUGE_GREY
        or  tile.sheet == LEVEL_HUGE_SOBER
        or  tile.sheet == LEVEL_HUGE_CLASSIC
end

-------------------------------------

function mayBeGrabbable(tile)
    if(isRealTile(tile)) then
        return tile.num == 4
    end

    if(tile.sheet == LEVEL_HUGE_GREEN) then
        return tile.num == 3
    end
end

-------------------------------------

function isSmallShape(tile)
    return (tile.num == 29 or tile.num == 30 or tile.num == 31 or tile.num == 32 
        or tile.num == 65 or tile.num == 66 or tile.num == 67 or tile.num == 68
        or tile.num == 83 or tile.num == 84 or tile.num == 85 or tile.num == 86
        or tile.num == 101 or tile.num == 102 or tile.num == 103 or tile.num == 104)  and isRealTile(tile)
end

-------------------------------------

function isRightTriangleShape(tile)
    return (tile.num == 35
        or tile.num == 71
        or tile.num == 89
        or tile.num == 57) and isRealTile(tile)
end

-------------------------------------

function isLeftTriangleShape(tile)
    return (tile.num == 33
        or tile.num == 69
        or tile.num == 87
        or tile.num == 56) and isRealTile(tile)
end

-------------------------------------

function bringForegroundToFront()
    for i=game.camera.numChildren,1,-1 do
        if(game.camera[i].foreground) then
            game.camera[i]:toFront()
        end
    end
end

function putBackgroundToBack()
    for i=1,game.camera.numChildren do
        if(game.camera[i].background) then
            game.camera[i]:toBack()
        end
    end
end

-------------------------------------

function openPanel(event)
    if(event.phase == "began") then
        hud.openPanel(level.num, event.target.panelNum)
    end
    return true
end

-------------------------------------

function drawTile(view, sheet, num, x, y)

    if(not sheet) then
        sheet = 1
    end

    local tile = display.newImage( view, imageSheets[sheet], num )
    tile.x             = x
    tile.y             = y
    tile.num             = num
    tile.sheet         = sheet

    return tile
end

---------------------------------------------------------------------

function addTriggerStarter(trigger, starter)
    if(level.triggers[trigger].start) then
        level.triggers[trigger].start[#level.triggers[trigger].start+1] = starter
    else
        level.triggers[trigger].start = {}
        level.triggers[trigger].start[1] = starter 
    end
end

---------------------------------------------------------------------

function addGroupMotion(group, motion)

    local motionStart     = vector2D:new(motion.x1, motion.y1)
    local motionEnd        = vector2D:new(motion.x2, motion.y2)
    local direction         = vector2D:Sub(motionEnd, motionStart)
    local distance            = direction:magnitude()
    local duration            = distance/MOTION_SPEED * 1000

    local motionVector     = vector2D:Normalize(direction)
    motionVector:mult(MOTION_SPEED)

    for i = 1, #group do
        group[i].bodyType = "kinematic"
        group[i].xStart = group[i].x
        group[i].yStart = group[i].y
        group[i].creationTime = game.creationTime
        startMoveTile(group[i], motionVector, duration)
    end
end

---------------------------------------------------------------------

-- amelioration : enterframe qui verif les x,y bien dans les bounds x1y1,x2y2 + stop tween + startMoveTile
function startMoveTile(tile, motionVector, duration)

    if(game.creationTime ~= tile.creationTime) then return end -- game stopped OR quickly gone to another level during 'duration'

    -- replace force au cas ou lag pendant le timer
    tile.x = tile.xStart
    tile.y = tile.yStart

    tile:setLinearVelocity( motionVector.x , motionVector.y )

    timer.performWithDelay(duration, function()
        if(game.creationTime ~= tile.creationTime) then return end -- game stopped OR quickly gone to another level during 'duration'

        tile:setLinearVelocity( - motionVector.x , - motionVector.y )
        timer.performWithDelay(duration, function()
            startMoveTile(tile, motionVector, duration)
        end)
    end)
end

---------------------------------------------------------------------

function addGroupDraggable(group, dragLine)

    local motionLimit = {}
    motionLimit.horizontal     = dragLine.x2 - dragLine.x1
    motionLimit.vertical     = dragLine.y2 - dragLine.y1

    for i = 1, #group do
        group[i].draggable = true
        group[i]:addEventListener( "touch", function(event)
            touchController.dragGroup(group, motionLimit, event)
        end)
    end

end

---------------------------------------------------------------------

function hitTrigger(trigger)

    level.triggers[trigger].remaining = level.triggers[trigger].remaining - 1

    if(level.triggers[trigger].remaining == 0) then
        for i = 1, #level.triggers[trigger].start do
            level.triggers[trigger].start[i]()

            local x,y = level.triggers[trigger].lockX, level.triggers[trigger].lockY

            timer.performWithDelay(200, function() effectsManager.drawTriggerTouched(x,y) end)
            timer.performWithDelay(600, function() effectsManager.drawTriggerTouched(x,y) end)
            effectsManager.unlockTrigger(x,y)
        end
    end
end
