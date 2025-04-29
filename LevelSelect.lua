local Screen = require "screen"

local LevelSelect = screen:extend()

local SCREEN_WIDTH = 800
local SCREEN_HEIGHT = 600
local x = 25
local y = 25
local MaxLevels = 10

function LevelSelect:new()
    self.super.new()
end

function LevelSelect:Update(dt)
    
    for i = 1

end

function LevelSelect:DrawScreen()
    love.graphics.rectangle("line",x,y,20,20)
end

function LevelSelect:Keypressed(key)
    
end