local Object = require "screen"
local Win = Object:extend()

local Button = require 'button'
local backButton = Button("Back",SCREEN_WIDTH/2 - 100, SCREEN_HEIGHT - 150, 200, 100, function() ChangeScreen(1) end, love.graphics.newFont(25))

function Win:load()
    
end

function Win:update(dt)
    
end

function Win:DrawScreen()
    love.graphics.setBackgroundColor(250,0,0)
    love.graphics.setColor(1, 1, 1) 
    love.graphics.print("You Won!", 700, 700, 0,5,5,100,100)

    -- Back Button
    backButton:render()

end

function Win:mousepressed(x,y,button)

    if button == 1 then
        backButton:checkPressed(x,y)
    end

end

return Win
