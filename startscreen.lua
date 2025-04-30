local Screen = require "screen"

local StartScreen = Screen:extend()

--start screen code goes here
local StartButton = {x = 250, y = 500, width = 300, height = 50}
local TitleBox = {x = 150, y = 100, width = 500, height = 100}

function StartScreen:new()
    self.super.new()
end


function StartScreen:load ()
   
end

function StartScreen:update (dt)

end

function StartScreen:DrawScreen()
   
    love.graphics.setBackgroundColor(0,1,0)
   love.graphics.setColor(0.8,0.1,0.1)
   love.graphics.rectangle("fill", StartButton.x,StartButton.y,StartButton.width,StartButton.height)
   love.graphics.setColor(1,1,1)
   local StartFont = love.graphics.newFont(25)
   love.graphics.setFont(StartFont)
   local StartText = "Start Game!"
   local StartTextWidth = StartFont:getWidth(StartText)
   local StartTextHeight = StartFont:getHeight(StartText)
   love.graphics.print(StartText, StartButton.x + (StartButton.width / 2) - (StartTextWidth / 2),
   StartButton.y + (StartButton.height / 2) - (StartTextHeight / 2))


   love.graphics.setColor(0.6,0.1,0.6)
   love.graphics.rectangle("fill", TitleBox.x,TitleBox.y, TitleBox.width,TitleBox.height)
   love.graphics.setColor(1,1,1)
   local TitleFont = love.graphics.newFont(70)
   love.graphics.setFont(TitleFont)
   local TitleText = "Recall Rush!"
   local TitleTextWidth = TitleFont:getWidth(TitleText)
   local TitleTextHeight = TitleFont:getHeight(TitleText)
   love.graphics.print(TitleText, TitleBox.x + (TitleBox.width / 2) - (TitleTextWidth / 2),
   TitleBox.y + (TitleBox.height / 2) - (TitleTextHeight / 2))


end

return StartScreen
