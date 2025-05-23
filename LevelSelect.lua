local Screen = require "screen"
local LevelSelect = Screen:extend()

local Button = require "button"

local levels = {}
local columns = 5  
local rows = 2     
local boxSize = 80
local spacing = 80
local offsetX, offsetY = 15, 200  


local bannerHeight = 100
local backButton = Button("Back",20,20,100,50,function() ChangeScreen(1) end, love.graphics.newFont(20),{1,1,1},{0.8,0.1,0.1})
local selectedIndex = 2


function LevelSelect:new()
     self.super.new()

     local levelNumber = 1
     for row = 0, rows - 1 do
         for col = 0, columns - 1 do
             table.insert(levels, {
                 x = offsetX + col * (boxSize + spacing),
                 y = offsetY + row * (boxSize + spacing),
                 size = boxSize,
                 number = levelNumber,
                 row = row,
                 col = col
             })
             levelNumber = levelNumber + 1

         end
     end

   
 end


function LevelSelect:load()
    local levelNumber = 1
    for row = 0, rows - 1 do
        for col = 0, columns - 1 do
            table.insert(levels, {
                x = offsetX + col * (boxSize + spacing),
                y = offsetY + row * (boxSize + spacing),
                size = boxSize,
                number = levelNumber,
                row = row,
                col = col
            })
            levelNumber = levelNumber + 1
        end
    end
    
end

function LevelSelect:Update(dt)

 -- Mouse hover detection
 local mouseX, mouseY = love.mouse.getPosition()
 for i, level in ipairs(levels) do
     if mouseX >= level.x and mouseX <= level.x + level.size and
        mouseY >= level.y and mouseY <= level.y + level.size then
         selectedIndex = i
         break
     end
 end

 end



function LevelSelect:DrawScreen()
    love.graphics.setBackgroundColor(0.1, 0.1, 0.1)

    -- Banner 
    love.graphics.setColor(0.2, 0.2, 0.2) 
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), bannerHeight)

    -- Draw "Level Selection" title
    love.graphics.setColor(1, 1, 1)
    local font = love.graphics.newFont(36)
    love.graphics.setFont(font)
    local title = "Level Selection"
    local titleWidth = font:getWidth(title)
    love.graphics.print(title, (love.graphics.getWidth() / 2) - (titleWidth / 2), 30)

    -- Back Button
    backButton:render()

    -- Level boxes
    love.graphics.setFont(love.graphics.newFont(14)) 
    for i, level in ipairs(levels) do
        -- Highlight selected
        if i == selectedIndex then
            love.graphics.setColor(1, 0, 0)
            love.graphics.rectangle("line", level.x - 4, level.y - 4, level.size + 8, level.size + 8)
        end

        -- Draw white box
        if Screens[level.number + 5].completed then
            love.graphics.setColor(0, 1, 0)
        else
            love.graphics.setColor(1, 1, 1)
        end
        
         love.graphics.rectangle("line", level.x, level.y, level.size, level.size)

        -- Draw number
         local text = tostring(level.number)
         local smallFont = love.graphics.getFont()
         local textWidth = smallFont:getWidth(text)
         local textHeight = smallFont:getHeight(text)

        love.graphics.print(text,
            level.x + (level.size / 2) - (textWidth / 2),
            level.y + (level.size / 2) - (textHeight / 2)
        )

        if Screens[level.number + 5].completed then
            love.graphics.print(Screens[level.number + 5].hiScore,
            level.x + (level.size / 2) - love.graphics.getFont():getWidth(tostring(Screens[level.number + 5].hiScore))/2,
            level.y + (level.size / 2) - (textHeight / 2) + 60)
        end
    end
end

function LevelSelect:Keypressed(key)
    local current = levels[selectedIndex]
    if not current then return end

    if key == "d" then
        for i, level in ipairs(levels) do
            if level.row == current.row and level.col == current.col + 1 then
                selectedIndex = i
                MenuNav:play()
                break
            end
        end
    elseif key == "a" then
        for i, level in ipairs(levels) do
            if level.row == current.row and level.col == current.col - 1 then
                selectedIndex = i
                MenuNav:play()
                break
            end
        end
    elseif key == "w" then
        for i, level in ipairs(levels) do
            if level.col == current.col and level.row == current.row - 1 then
                selectedIndex = i
                MenuNav:play()
                break
            end
        end
    elseif key == "s" then
        for i, level in ipairs(levels) do
            if level.col == current.col and level.row == current.row + 1 then
                selectedIndex = i
                MenuNav:play()
                break
            end
        end
    elseif key == "return" or key == "kpenter" then
        SelectSfx:play()
        ChangeScreen(current.number + 5)
    end
end

 -- Mouse hover detection
 local mouseX, mouseY = love.mouse.getPosition()
 for i, level in ipairs(levels) do
     if  mouseX >= level.x and mouseX <= level.x + level.size and
         mouseY >= level.y and mouseY <= level.y + level.size then
         selectedIndex = i
         break
     end
 end

function LevelSelect:MousePressed(x, y, button)
    if button == 1 then

        -- Check if clicked a level
        for i, level in ipairs(levels) do
            if x >= level.x and x <= level.x + level.size and
               y >= level.y and y <= level.y + level.size then
                selectedIndex = i
                SelectSfx:play()
                ChangeScreen(level.number + 5)
                break
            end
        end

        backButton:CheckPressed(x,y)

    end
end

return LevelSelect

-- end

