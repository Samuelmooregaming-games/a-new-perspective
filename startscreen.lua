 local Screen = require "screen"

 local StartScreen = Screen:extend()

 --start screen code goes here
 local StartButton = {x = 200, y = 200, width = 100, height = 100}

 function StartScreen:new()
     self.super.new()
 end


function StartScreen:load ()
    
end

function StartScreen:update (dt)

end

function StartScreen:DrawScreen()
    
    love.graphics.rectangle("fill", StartButton.x,StartButton.y,StartButton.width,StartButton.height)
end

 return StartScreen