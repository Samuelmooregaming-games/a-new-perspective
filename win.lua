local Object = require "screen"
local Win = Object:extend()

local backButton = { x = SCREEN_WIDTH/2 - 100, y = SCREEN_HEIGHT - 150, width = 200, height = 100 }

function Win:load()
    
end

function Win:update(dt)
    
end

function Win:DrawScreen()
    love.graphics.setBackgroundColor(250,0,0)
    love.graphics.setColor(1, 1, 1) 
    love.graphics.print("You Won!", 700, 700, 0,5,5,100,100)

    -- Back Button
    love.graphics.setColor(1, 1, 1) 
    love.graphics.rectangle("fill", backButton.x, backButton.y, backButton.width, backButton.height)

    love.graphics.setColor(1, 0, 0)
    local backFont = love.graphics.newFont(20)
    love.graphics.setFont(backFont)
    local backText = "Back"
    local backTextWidth = backFont:getWidth(backText)
    local backTextHeight = backFont:getHeight(backText)
    love.graphics.print(backText,
        backButton.x + (backButton.width / 2) - (backTextWidth / 2),
        backButton.y + (backButton.height / 2) - (backTextHeight / 2)
    )

end

function Win:mousepressed(x,y,button)

    if button == 1 then
        
        if x >= backButton.x and x <= backButton.x + backButton.width and
           y >= backButton.y and y <= backButton.y + backButton.height then
            print("Back button pressed!")
            SelectSfx:play()
            ChangeScreen(1)
            -- Here we will switch back to the main menu
            return
        end
    end

end

return Win
