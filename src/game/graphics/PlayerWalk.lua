-----
---- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
--local PlayerWalk = {}
--
--PlayerWalk.sheet =
--{
--    frames = {
--
--        {
--            -- p1_walk01
--            x=74,
--            y=100,
--            width=34,
--            height=47,
--
--            sourceX = 2,
--            sourceY = 0,
--            sourceWidth = 36,
--            sourceHeight = 49
--        },
--        {
--            -- p1_walk02
--            x=2,
--            y=198,
--            width=33,
--            height=47,
--
--            sourceX = 3,
--            sourceY = 0,
--            sourceWidth = 36,
--            sourceHeight = 49
--        },
--        {
--            -- p1_walk03
--            x=78,
--            y=2,
--            width=36,
--            height=47,
--
--            sourceX = 0,
--            sourceY = 0,
--            sourceWidth = 36,
--            sourceHeight = 49
--        },
--        {
--            -- p1_walk04
--            x=40,
--            y=2,
--            width=36,
--            height=47,
--
--            sourceX = 0,
--            sourceY = 0,
--            sourceWidth = 36,
--            sourceHeight = 49
--        },
--        {
--            -- p1_walk05
--            x=2,
--            y=2,
--            width=36,
--            height=47,
--
--            sourceX = 0,
--            sourceY = 1,
--            sourceWidth = 36,
--            sourceHeight = 49
--        },
--        {
--            -- p1_walk06
--            x=39,
--            y=51,
--            width=35,
--            height=47,
--
--            sourceX = 0,
--            sourceY = 1,
--            sourceWidth = 36,
--            sourceHeight = 49
--        },
--        {
--            -- p1_walk07
--            x=2,
--            y=51,
--            width=35,
--            height=47,
--
--            sourceX = 0,
--            sourceY = 2,
--            sourceWidth = 36,
--            sourceHeight = 49
--        },
--        {
--            -- p1_walk08
--            x=38,
--            y=100,
--            width=34,
--            height=47,
--
--            sourceX = 1,
--            sourceY = 2,
--            sourceWidth = 36,
--            sourceHeight = 49
--        },
--        {
--            -- p1_walk09
--            x=2,
--            y=100,
--            width=34,
--            height=47,
--
--            sourceX = 1,
--            sourceY = 2,
--            sourceWidth = 36,
--            sourceHeight = 49
--        },
--        {
--            -- p1_walk10
--            x=76,
--            y=51,
--            width=34,
--            height=47,
--
--            sourceX = 1,
--            sourceY = 2,
--            sourceWidth = 36,
--            sourceHeight = 49
--        },
--        {
--            -- p1_walk11
--            x=2,
--            y=149,
--            width=33,
--            height=47,
--
--            sourceX = 2,
--            sourceY = 1,
--            sourceWidth = 36,
--            sourceHeight = 49
--        },
--    },
--
--    sheetContentWidth = 128,
--    sheetContentHeight = 256
--}
--
--PlayerWalk.frameIndex =
--{
--
--    ["p1_walk01"] = 1,
--    ["p1_walk02"] = 2,
--    ["p1_walk03"] = 3,
--    ["p1_walk04"] = 4,
--    ["p1_walk05"] = 5,
--    ["p1_walk06"] = 6,
--    ["p1_walk07"] = 7,
--    ["p1_walk08"] = 8,
--    ["p1_walk09"] = 9,
--    ["p1_walk10"] = 10,
--    ["p1_walk11"] = 11,
--}
--
--function PlayerWalk:getSheet()
--    return self.sheet;
--end
--
--function PlayerWalk:getFrameIndex(name)
--    return self.frameIndex[name];
--end
--
--return PlayerWalk