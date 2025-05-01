local Screen = require "screen"

local Level = Screen:extend()


--[[

0 = open space
1 = player start (also open space)
2 = reveal button
3 = exit
4 = walls
5 = fake walls

]]

local backButton1 = { x = 20, y = 20, width = 100, height = 50 }
local backButton2 = { x = SCREEN_WIDTH/2 - 50, y = SCREEN_HEIGHT/2, width = 100, height = 50 }
local winRectangle = {x = 150,y =150,width = 500,height = 250}

function Level:new(map,mapWidth)
    self.super.new()
    self.map = map
    self.mapWidth = mapWidth
    self.tileWidth = 32
    self.completed = false
    self.onWinTile = false
    self.button = {}
    self.player = {}
    self.exit = {}
    self.exitRevealed = false


    self.WallTexture = love.graphics.newImage("Textures/gratewall.png")
    self.FloorTexture = love.graphics.newImage("Textures/floorskin.png")
    self.RevealTexture = love.graphics.newImage("Textures/lightwall.png")
    self.ExitTexture = love.graphics.newImage("Textures/bigdoor.png")
    
    self.PlayerTexture = love.graphics.newImage("Textures/playerball.png")
    
     self.image_width = self.PlayerTexture:getWidth()
    self.image_height = self.PlayerTexture:getHeight()
    width = (self.image_width / 4)
    height = (self.image_height)
    maxquads = 4
    Currentquad = 1

    quads = {}
    for i = 0, 1 do
        for j = 0, 2 do
            if #quads == maxquads then
                break
            end
            table.insert(quads, love.graphics.newQuad(
                 j * (width),
                 i * (height),
                width, height,
                self.image_width, self.image_height))
        end
    end





    self.originalMap = map

    for i, v in ipairs(map) do
        if v == 1 then
            self.player.x = math.fmod(i - 1, self.mapWidth)
            self.player.y = math.floor((i - 1) / self.mapWidth)
        elseif v == 2 then
            self.button.x = math.fmod(i - 1, self.mapWidth)
            self.button.y = math.floor((i - 1) / self.mapWidth)
        elseif v == 3 then
            self.exit.x = math.fmod(i - 1, self.mapWidth)
            self.exit.y = math.floor((i - 1) / self.mapWidth)
        end
    end
   
end

function Level:DrawScreen()
    self.super.DrawScreen()
   


    -- these varaibles define the top left corner of the tile grid
    local mapOffsetX = love.graphics.getWidth()/2 - (self.tileWidth*self.mapWidth)/2
    local mapOffsetY = love.graphics.getHeight()/2 - (self.tileWidth* math.ceil(#self.map / self.mapWidth) )/2

    for i, v in ipairs(self.map) do
        local tileX = math.fmod(i - 1, self.mapWidth) * self.tileWidth + mapOffsetX
        local tileY = math.floor((i - 1) / self.mapWidth) * self.tileWidth + mapOffsetY
    
        --reveal
        local revealing = (self.player.x == self.button.x and self.player.y == self.button.y)
    
        if v == 0 or v == 1 then
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(self.FloorTexture, tileX, tileY,0,.125,.125)
        elseif v == 2 then
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(self.RevealTexture, tileX, tileY,0,.5,.5)
        elseif v == 3 then
            if revealing then
                love.graphics.setColor(.83, .68, .21) -- revealed exit = Gold
                love.graphics.draw(self.ExitTexture, tileX, tileY,0,.125,.125)
            else
                love.graphics.setColor(1, 1, 1)
                love.graphics.draw(self.FloorTexture, tileX, tileY,0,.125,.125)
            end
            
        elseif v == 4 then
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(self.WallTexture, tileX, tileY,0,.125,.125)
        elseif v == 5 then
            if revealing then
                love.graphics.setColor(0.6, 1, 0.6)  -- fake walls = light green when revealed
                love.graphics.draw(self.WallTexture, tileX, tileY,0,.125,.125)
            else
                love.graphics.setColor(1, 1, 1)
                love.graphics.draw(self.WallTexture, tileX, tileY,0,.125,.125)
            end
        end
    end
    
    if not self.player.x or not self.player.y then
        error("Player start (tile 1) not found in the map!")
    end

    love.graphics.setColor(1,1,1)
    love.graphics.draw(self.PlayerTexture, quads[math.floor(Currentquad)], (self.player.x*self.tileWidth) + mapOffsetX,  (self.player.y*self.tileWidth) + mapOffsetY )
    

    -- Back Button 1
    love.graphics.setColor(0.8, 0.1, 0.1) 
    love.graphics.rectangle("fill", backButton1.x, backButton1.y, backButton1.width, backButton1.height)

    love.graphics.setColor(1, 1, 1)
    local backFont = love.graphics.newFont(20)
    love.graphics.setFont(backFont)
    local backText = "Back"
    local backTextWidth = backFont:getWidth(backText)
    local backTextHeight = backFont:getHeight(backText)
    love.graphics.print(backText,
        backButton1.x + (backButton1.width / 2) - (backTextWidth / 2),
        backButton1.y + (backButton1.height / 2) - (backTextHeight / 2)
    )

    
    if self.onWinTile then

        --win popup
        love.graphics.setColor(0, 0.7, 0) 
        love.graphics.rectangle("fill",winRectangle.x,winRectangle.y,winRectangle.width,winRectangle.height)
        winFont = love.graphics.newFont(30)
        love.graphics.setFont(winFont)
        local winText = "YOU WIN!"
        local winTextWidth = winFont:getWidth(winText)
        local winTextHeight = winFont:getHeight(winText)
        love.graphics.setColor(1, 1, 1) 
        love.graphics.print("YOU WIN",
            winRectangle.x + (winRectangle.width / 2) - (winTextWidth / 2),
            winRectangle.y + (winRectangle.height / 2) - (winTextHeight / 2) - 50
        )

        -- Back Button 2
        love.graphics.setColor(0, 0, 0) 
        love.graphics.rectangle("fill", backButton2.x, backButton2.y, backButton2.width, backButton2.height)
        love.graphics.setColor(1, 1, 1)
        love.graphics.setFont(backFont)
        love.graphics.print(backText,
            backButton2.x + (backButton2.width / 2) - (backTextWidth / 2),
            backButton2.y + (backButton2.height / 2) - (backTextHeight / 2)
        )
    end

end

function Level:Update(dt)
    self.super.Update(dt)


    if self.player.x == self.button.x and self.player.y == self.button.y then
        self.exitRevealed = true
    end


Currentquad = Currentquad + 10 * dt
if Currentquad>= 4 then
    Currentquad = 1
end

    if self.onWinTile == false then
        if self.player.x == self.exit.x and self.player.y == self.exit.y and self.exitRevealed then
            self.completed = true
            self.onWinTile = true
            local allCompleted = true
            for i, v in ipairs(Screens)do
                if v.completed == false then
                    allCompleted = false
                    break
                end
            end
            if allCompleted == true then
                ChangeScreen(3)
            end
        end
    end
    


end

function Level:Reset()
    self.super.Reset()
    self.map = self.originalMap
    self.onWinTile = false
    self.exitRevealed = false

    for i, v in ipairs(self.map) do
        if v == 1 then
            self.player.x = math.fmod(i - 1, self.mapWidth)
            self.player.y = math.floor(i / self.mapWidth)
        end
    end

end



function Level:Keypressed(key)


    self.super.Keypressed(key)

    -- do not alow key movement after level completion
    if self.onWinTile then
        return
    end

    -- reset button
    if key == "r" then
        -- Reset 
        self:Reset()
    end

    -- player movement
    local x = self.player.x
    local y = self.player.y

    if key == "a" then
        x = x - 1
    elseif key == "d" then
        x = x + 1
    elseif key == "w" then
        y = y - 1
    elseif key == "s" then
        y = y + 1
    end

    -- player collisions
    if x >= 0 and x < self.mapWidth and y >= 0 and y < math.ceil(#self.map / self.mapWidth) then
        local index = (y * self.mapWidth) + x + 1
        if self.map[index] ~= 4 then  -- 4 is a wall
            if self.player.x ~= x or self.player.y ~= y then
                if Step:isPlaying() then
                    Step:stop()
                end
                Step:play()
            end
            
            self.player.x = x
            self.player.y = y
            
        end
    end

end

function Level:mousepressed(x, y, button)
    self.super.mousepressed()
    if button == 1 then
        
        if x >= backButton1.x and x <= backButton1.x + backButton1.width and
           y >= backButton1.y and y <= backButton1.y + backButton1.height then
            print("Back button pressed!")
            ChangeScreen(2)
            SelectSfx:play()
            -- Here we will switch back to the main menu
            return
        end

        if self.onWinTile then
            if x >= backButton2.x and x <= backButton2.x + backButton2.width and
                y >= backButton2.y and y <= backButton2.y + backButton2.height then
                    print("Back button pressed!")
                    ChangeScreen(2)
                    -- Here we will switch back to the main menu
                    return
            end
        end

    end
end


return Level

