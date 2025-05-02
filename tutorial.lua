local Screen = require "screen"


local TutorialScreen = Screen:extend()

function TutorialScreen:new()
    self.super.new()
    self.tutorialtexture = love.graphics.newImage("Textures/Tutorial.png")
   
end

function TutorialScreen:update (dt)

end

function TutorialScreen:DrawScreen()
    love.graphics.draw(self.tutorialtexture, SCREEN_WIDTH / 2 - self.tutorialtexture:getWidth() / 2, SCREEN_HEIGHT/2 - self.tutorialtexture:getHeight() / 2 )
end