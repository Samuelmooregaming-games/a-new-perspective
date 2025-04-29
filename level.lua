local Screen = require "screen"

local Level = Screen:extend()


--[[

0 = open space
1 = player start (also open space)
2 = reveal button
3 = exit

]]

function Level:new(map,mapWidth)
    self.super.new()
    self.map = map
    self.mapWidth = mapWidth
    self.tileWidth = 32

    self.player = {}

    local playerX, playerY

    for i, v in ipairs(map) do
        if v == 1 then
            playerX = math.fmod(i-1,self.mapWidth)
            playerY = math.floor(i/self.mapWidth)
        end
    end

    self.player.x = playerX
    self.player.y = playerY

end


 function Level:DrawScreen()
     self.super.DrawScreen()


    -- these varaibles define the top 
    local mapOffsetX = love.graphics.getWidth()/2 - (self.tileWidth*self.mapWidth)/2
    local mapOffsetY = love.graphics.getHeight()/2 - (self.tileWidth* math.ceil(#self.map / self.mapWidth) )/2

    for i, v in ipairs(self.map) do
        if v == 0 or v == 1 then
            love.graphics.setColor(1,0,0)
        elseif v == 2 then
            love.graphics.setColor(0,1,1)
        end
        love.graphics.rectangle("fill", math.fmod(i-1,self.mapWidth)*(self.tileWidth) + mapOffsetX ,math.floor((i-1)/self.mapWidth)*(self.tileWidth) + mapOffsetY, self.tileWidth, self.tileWidth)
    end


    love.graphics.setColor(1,1,1)
    love.graphics.circle("fill", (self.player.x*self.tileWidth) + mapOffsetX + self.tileWidth/2, (self.player.y*self.tileWidth) + mapOffsetY + self.tileWidth/2,10)

end

function Level:Update(dt)
    self.super.Update(dt)



end

function Level:Keypressed(key)

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

    if self.map[(y*self.mapWidth) + x + 1] == 0 then
        self.player.x = x
        self.player.y = y
    end

end

 return Level