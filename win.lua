local Object = require "screen"
local Win = Object:extend()

local Button = require 'button'
local backButton = Button("Back",SCREEN_WIDTH/2 - 100, SCREEN_HEIGHT - 150, 200, 100, function() ChangeScreen(1) end, love.graphics.newFont(25),{0.8,0.1,0.1},{1,1,1})

function Win:load()
    
end

function Win:update(dt)
    
end

function Win:DrawScreen()
    love.graphics.setBackgroundColor(.1,.1,.1)

     
    local winText = "You Won!"
    local font = love.graphics.newFont(64)
    love.graphics.setFont(font)
    local textWidth = font:getWidth(winText)
    local textHeight = font:getHeight()
    local screenWidth, screenHeight = love.graphics.getDimensions()
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(winText, (screenWidth - textWidth) / 2, screenHeight / 4)

    -- Draw total score
    local scoreText = "Total Score: " .. tostring(GetTotalScore() or 0)
    local scoreFont = love.graphics.newFont(32)
    love.graphics.setFont(scoreFont)
    local scoreWidth = scoreFont:getWidth(scoreText)
    love.graphics.print(scoreText, (screenWidth - scoreWidth) / 2, screenHeight / 4 + textHeight + 20)


    -- Back Button
    backButton:render()
    WinSFX:play()
end

function Win:mousepressed(x,y,button)

    if button == 1 then
        backButton:checkPressed(x,y)
    end

end

return Win
