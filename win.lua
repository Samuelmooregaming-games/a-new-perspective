local Object = require "screen"
local Win = Object:extend()

function Win:load()
    
end

function Win:update()
    
end

function Win:DrawScreen()
    love.graphics.setBackgroundColor(250,0,0)
    love.graphics.print("You Won!", 700, 700, 0,5,5,100,100)
end


return Win
