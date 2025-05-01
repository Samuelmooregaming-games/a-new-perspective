local Screen = require "screen"
local LevelSelect = Screen:extend()

local levels = {}
local columns = 5  
local rows = 2     
local boxSize = 80
local spacing = 80
local offsetX, offsetY = 15, 200  


local bannerHeight = 100
local backButton = { x = 20, y = 20, width = 100, height = 50 }
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
    love.graphics.setColor(0.8, 0.1, 0.1) 
    love.graphics.rectangle("fill", backButton.x, backButton.y, backButton.width, backButton.height)

    love.graphics.setColor(1, 1, 1)
    local backFont = love.graphics.newFont(20)
    love.graphics.setFont(backFont)
    local backText = "Back"
    local backTextWidth = backFont:getWidth(backText)
    local backTextHeight = backFont:getHeight(backText)
    love.graphics.print(backText,
        backButton.x + (backButton.width / 2) - (backTextWidth / 2),
        backButton.y + (backButton.height / 2) - (backTextHeight / 2)
    )

    -- Level boxes
    love.graphics.setFont(love.graphics.newFont(14)) 
    for i, level in ipairs(levels) do
        -- Highlight selected
        if i == selectedIndex then
            love.graphics.setColor(1, 0, 0)
            love.graphics.rectangle("line", level.x - 4, level.y - 4, level.size + 8, level.size + 8)
        end

        -- Draw white box
        if Screens[level.number + 3].completed then
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
        print("Level " .. current.number .. " selected!")
        SelectSfx:play()
        ChangeScreen(current.number + 3)
        
    end
end

 -- Mouse hover detection
 local mouseX, mouseY = love.mouse.getPosition()
 for i, level in ipairs(levels) do
     if mouseX >= level.x and mouseX <= level.x + level.size and
        mouseY >= level.y and mouseY <= level.y + level.size then
         selectedIndex = i
         break
     end
 end

function LevelSelect:mousepressed(x, y, button)
    if button == 1 then
        
        if x >= backButton.x and x <= backButton.x + backButton.width and
           y >= backButton.y and y <= backButton.y + backButton.height then
            print("Back button pressed!")
            SelectSfx:play()
            ChangeScreen(1)
            -- Here we will switch back to the main menu
            return
        end

        -- Check if clicked a level
        for i, level in ipairs(levels) do
            if x >= level.x and x <= level.x + level.size and
               y >= level.y and y <= level.y + level.size then
                selectedIndex = i
                print("Level " .. level.number .. " selected!")
                SelectSfx:play()
                ChangeScreen(level.number + 3)
                break
            end
        end
    end
end

return LevelSelect

-- end

