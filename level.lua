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

local backButton = { x = 20, y = 20, width = 100, height = 50 }

function Level:new(map,mapWidth)
    self.super.new()
    self.map = map
    self.mapWidth = mapWidth
    self.tileWidth = 32
    self.button = {}
    self.player = {}
    self.exit = {}

    self.WallTexture = love.graphics.newImage("Textures/gratewall.png")
    self.FloorTexture = love.graphics.newImage("Textures/floorskin.png")
    self.RevealTexture = love.graphics.newImage("Textures/lightwall.png")
    self.ExitTexture = love.graphics.newImage("Textures/bigdoor.png")
    




    self.originalMap = {unpack(map)}

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
    love.graphics.circle("fill", (self.player.x*self.tileWidth) + mapOffsetX + self.tileWidth/2, (self.player.y*self.tileWidth) + mapOffsetY + self.tileWidth/2,10)


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

end

function Level:Update(dt)
    self.super.Update(dt)

    if self.player.x == self.exit.x and self.player.y == self.exit.y then
        print("player win")
    end

end

function Level:Reset()
    self.super.Reset()
    self.map = {unpack(self.originalMap)}
end


function Level:Keypressed(key)

    if key == "r" then
        -- Reset 
        self:Reset()
    
        for i, v in ipairs(self.map) do
            if v == 1 then
                self.player.x = math.fmod(i - 1, self.mapWidth)
                self.player.y = math.floor(i / self.mapWidth)
            end
        end
        return
    end

    self.super.Keypressed(key)

    local x = self.player.x
    local y = self.player.y

    if key == "left" then
        x = x - 1
    elseif key == "right" then
        x = x + 1
    elseif key == "up" then
        y = y - 1
    elseif key == "down" then
        y = y + 1
    end

    local index = (y * self.mapWidth) + x + 1

    if x >= 0 and x < self.mapWidth and y >= 0 and y < math.ceil(#self.map / self.mapWidth) then
        local index = (y * self.mapWidth) + x + 1
        if self.map[index] ~= 4 then  -- 4 is a wall
            self.player.x = x
            self.player.y = y
        end
    end

end

function Level:mousepressed(x, y, button)
    self.super.mousepressed()
    if button == 1 then
        
        if x >= backButton.x and x <= backButton.x + backButton.width and
           y >= backButton.y and y <= backButton.y + backButton.height then
            print("Back button pressed!")
            ChangeScreen(2)
            -- Here we will switch back to the main menu
            return
        end
    end
end


return Level

