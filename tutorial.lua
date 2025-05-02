local Screen = require "screen"
local Button = require("button")

local TutorialScreen = Screen:extend()
local Xbutton = Button("X",SCREEN_WIDTH - 50,25,25,25,function() ChangeScreen(1) end, love.graphics.newFont(25),{1,1,1},{.8,.1,.1})
function TutorialScreen:new()
    self.super.new()
    self.tutorialtexture = love.graphics.newImage("Textures/Tutorial.png")
    
   
end

function TutorialScreen:update (dt)

end

function TutorialScreen:DrawScreen()
    
    love.graphics.draw(self.tutorialtexture, SCREEN_WIDTH / 2 - self.tutorialtexture:getWidth() / 2, SCREEN_HEIGHT/2 - self.tutorialtexture:getHeight() / 2)
    Xbutton:render()
end

function TutorialScreen:mousepressed(x, y, button)
    if button == 1 then
        Xbutton:checkPressed(x,y)
    end
end

return TutorialScreen