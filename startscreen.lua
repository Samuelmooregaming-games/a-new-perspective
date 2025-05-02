local Screen = require "screen"
local Button = require("button")

local StartScreen = Screen:extend()

--start screen code goes here
local TitleBox = {x = 150, y = 100, width = 500, height = 100}



local startButton = Button("Start",250,500,300,50,function() ChangeScreen(2) end,love.graphics.newFont(25),{1,1,1},{0.8,0.1,0.1})
local tutorialbutton = Button("Tutorial",250,300,300,50,function() ChangeScreen(4) end, love.graphics.newFont(25),{1,1,1},{0.6,0.1,152})


function StartScreen:new()
    self.super.new()

end

function StartScreen:update (dt)

end

function StartScreen:DrawScreen()
   


    love.graphics.setBackgroundColor(.1,.1,.1)


    startButton:render()

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


   tutorialbutton:render()



end
   


function StartScreen:mousepressed(x, y, button)
    if button == 1 then

        startButton:checkPressed(x,y)
        tutorialbutton:checkPressed(x,y)


    end
end







return StartScreen