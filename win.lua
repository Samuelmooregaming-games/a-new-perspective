local Screen = require "screen"
local Win = Object:extend()
function Win.load()
    
end

function Win.update()
    
end

function Win.DrawScreen ()
    love.graphics.print("You Won!", 400, 400, 0,0,0,100,100)
end


return Win
