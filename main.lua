if arg[2] == "debug" then
    require("lldebugger").start()
end

SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600

 SCREEN_INDEX = 1


 
--[[

screen objects
    start
    level select
    level
    win

menus
level logic
transitions


button
    create a button module
    wasd controls in menu
mouse control
    set up basic mouse control functions for menus

]]--

function love.load()
     local Screen = require("screen")
    -- local StartScreen = require "startscreen"
    -- local LevelSelect = require "LevelSelect"
    -- local Level = require "level"
    local Win = require "win"
    Screens = {}

    --create screens here
   -- table.insert(StartScreen())
    --table.insert(LevelSelect())
    --table.insert(Level())
    table.insert(Screens, Win())
end

function love.update(dt)
    Screens[SCREEN_INDEX]:Update(dt)

end

function love.draw() 
    Screens[SCREEN_INDEX]:DrawScreen()
    
end    

function love.keypressed(key)
    Screens[SCREEN_INDEX]:Keypressed(key)
end

local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end
