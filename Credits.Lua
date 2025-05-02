local Object = require "screen"
local Credits = Object:extend()

local Button = require "button"

local backButton = Button("Back",20,20,100,50,function() ChangeScreen(1) end, love.graphics.newFont(20),{1,1,1},{0.8,0.1,0.1})

function Credits:load()
    
end

function Credits:update()
    
end

function Credits:DrawScreen()
    love.graphics.setBackgroundColor(0.1, 0.1, 0.1)

    local boxWidth = 250
    local boxHeight = 150
    local spacing = (love.graphics.getWidth() - (3 * boxWidth)) / 4
    local startY = love.graphics.getHeight() / 2 - boxHeight / 2
    local font = love.graphics.newFont(18)
    love.graphics.setFont(font)

    local creditTexts = {
        { "Ryan Engelhardt", "Pseudo"},
        { "Samuel Moore", "samuelmooregaminggames"},
        { "Justin Northcott", "CPF Storm" }
    }

    for i = 1, 3 do
        local x = spacing * i + boxWidth * (i - 1)
        love.graphics.setColor(0.2, 0.2, 0.2)
        love.graphics.rectangle("fill", x, startY, boxWidth, boxHeight, 10, 10)

        love.graphics.setColor(1, 1, 1)
        local title = creditTexts[i][1]
        local name = creditTexts[i][2]

        love.graphics.printf(title, x, startY + 20, boxWidth, "center")
        love.graphics.printf(name, x, startY + 60, boxWidth, "center")
    end

    backButton:render()
end

function Credits:mousepressed(x,y,button)
    if button == 1 then

        backButton:checkPressed(x,y)

    end
end

return Credits