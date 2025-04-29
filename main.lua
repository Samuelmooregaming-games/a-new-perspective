if arg[2] == "debug" then
    require("lldebugger").start()
end

SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600

 SCREEN_INDEX = 1

function love.load()
    local LevelSelect = require "LevelSelect"
    local Level = require "level"
    local WinScreen = require "win"
    Screens = {}

    --create screens here
    table.insert(Screens, LevelSelect())
    table.insert(Screens, Level(
    {
        0,0,2,0,0,0,
        0,0,2,0,0,0,
        0,2,1,0,0,0,
        0,0,2,0,0,0,
        0,0,2,0,0,0
    },
    6
    ))
    table.insert(Screens, WinScreen)

end

function love.update(dt)
    Screens[SCREEN_INDEX]:Update(dt)

end

function love.draw() 
    Screens[SCREEN_INDEX]:DrawScreen()
    
end    

function love.keypressed(key)
    Screens[SCREEN_INDEX]:Keypressed(key)
    if key == "space" then
        SCREEN_INDEX = SCREEN_INDEX + 1
        if SCREEN_INDEX > 3 then
            SCREEN_INDEX = 1
        end
    end
end

local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end
