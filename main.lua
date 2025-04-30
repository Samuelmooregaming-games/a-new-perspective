if arg[2] == "debug" then
    require("lldebugger").start()
end

SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600

local SCREEN_INDEX = 2

function ChangeScreen(index)

    if index > #Screens then
        print("invalid index")
        return
    end

    SCREEN_INDEX = index

    Screens[SCREEN_INDEX]:Reset()

end

function love.load()
    local LevelSelect = require "LevelSelect"
    local Level = require "level"
    local WinScreen = require "win"
    local StartScreen = require "startScreen"
    Screens = {}

    --create screens here
    table.insert(Screens, StartScreen())
    table.insert(Screens, LevelSelect())
    table.insert(Screens, WinScreen())
    table.insert(Screens, Level(
    {
        {
            4,4,4,4,4,4,4,4,4,4,
            4,1,0,0,4,0,0,5,2,4,
            4,0,4,0,4,0,4,5,0,4,
            4,0,4,0,0,0,4,5,0,4,
            4,0,4,4,4,0,0,0,0,4,
            4,4,4,4,4,4,4,3,4,4
        }
    },
    10
    ))
    table.insert(Screens, Level(
    {
        0,0,0,0,0,0,0,0,0,1,
        0,0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,0,0,
        0,0,0,0,2,0,0,0,0,0,
        0,0,0,0,0,0,0,3,0,0
    },
    10
    ))
    

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
