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

function Level:new(map,mapWidth)
    self.super.new()
    self.map = map
    self.mapWidth = mapWidth
    self.tileWidth = 32
    self.button = {}
    self.player = {}
    self.exit = {}
  --  self.wallTexture = love.graphics.newImage("")  -- make sure '.png' is 32x32 and in the project directory
    --self.originalMap = {table.unpack(map)}


    local playerX, playerY

    for i, v in ipairs(map) do
        if v == 1 then
            self.player.x = math.fmod(i-1,self.mapWidth)
            self.player.y = math.floor(i/self.mapWidth)
        elseif v == 2 then
            self.button.x = math.fmod(i-1,self.mapWidth)
            self.button.y = math.floor(i/self.mapWidth)
        elseif v == 3 then
            self.exit.x = math.fmod(i-1,self.mapWidth)
            self.exit.y = math.floor(i/self.mapWidth)
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
            love.graphics.setColor(1, 0, 0)
            love.graphics.rectangle("fill", tileX, tileY, self.tileWidth, self.tileWidth)
        elseif v == 2 then
            love.graphics.setColor(0, 0, 1)
            love.graphics.rectangle("fill", tileX, tileY, self.tileWidth, self.tileWidth)
        elseif v == 3 then
            if revealing then
                love.graphics.setColor(.83, .68, .21) -- revealed exit = Gold
            else
                love.graphics.setColor(1, 0, 0)
            end
            love.graphics.rectangle("fill", tileX, tileY, self.tileWidth, self.tileWidth)
        elseif v == 4 then
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(self.wallTexture, tileX, tileY)
        elseif v == 5 then
            if revealing then
                love.graphics.setColor(0.6, 1, 0.6)  -- fake walls = light green when revealed
                love.graphics.rectangle("fill", tileX, tileY, self.tileWidth, self.tileWidth)
            else
                love.graphics.setColor(1, 1, 1)
                love.graphics.draw(self.wallTexture, tileX, tileY)
            end
        end
    end
    


    love.graphics.setColor(1,1,1)
    love.graphics.circle("fill", (self.player.x*self.tileWidth) + mapOffsetX + self.tileWidth/2, (self.player.y*self.tileWidth) + mapOffsetY + self.tileWidth/2,10)

end

function Level:Update(dt)
    self.super.Update(dt)

    if self.player.x == self.exit.x and self.player.y == self.exit.y then
        print("player win")
    end

end

function Level:Keypressed(key)

    if key == "r" then
        -- Reset 
        self.map = {table.unpack(self.originalMap)}
    
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


return Level

