local Screen = require "screen"


local StartScreen = Screen:extend()

--start screen code goes here
local StartButton = {x = 250, y = 500, width = 300, height = 50}
local TitleBox = {x = 150, y = 100, width = 500, height = 100}
local tutorialBox = {x = 250, y = 300, width = 300, height = 50}



function StartScreen:new()
    self.super.new()

end


function StartScreen:load ()
   
end

function StartScreen:update (dt)

end

function StartScreen:DrawScreen()
   
    love.graphics.setBackgroundColor(.1,.1,.1)
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


   love.graphics.setColor(0.6,0.1,152)
   love.graphics.rectangle("fill", tutorialBox.x,tutorialBox.y, tutorialBox.width,tutorialBox.height)
   love.graphics.setColor(1,1,1)
   local tutorialFont = love.graphics.newFont(25)
   love.graphics.setFont(tutorialFont)
   local tutorialText = "tutorial"
   local tutorialTextWidth = tutorialFont:getWidth(tutorialText)
   local tutorialTextHeight = tutorialFont:getHeight(tutorialText)
   love.graphics.print(tutorialText, tutorialBox.x + (tutorialBox.width / 2) - (tutorialTextWidth / 2),
   tutorialBox.y + (tutorialBox.height / 2) - (tutorialTextHeight / 2))



end
   
   function StartScreen:mousepressed(x, y, button)
    if button == 1 then
        
        if x >= StartButton.x and x <= StartButton.x + StartButton.width and
           y >= StartButton.y and y <= StartButton.y + StartButton.height then
            print("Start button pressed!")
            SelectSfx:play()
            ChangeScreen(2)
            -- Here we will switch back to the main menu
            return
        end



        
            end
        end
    






return StartScreen