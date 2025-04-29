local Screen = require "screen"

local Level = Screen:extend()

--start screen code goes here

function Level:new()
    self.super.new()
    self.map = {
        1,0,0,0,
        0,1,0,0,
        0,0,1,0,
        0,0,0,1,
    }
    self.MapWidth = 4
    self.tileWidth = 32

end

function Level:DrawScreen()
    self.super.DrawScreen()

    local mapOffsetX = love.graphics.getWidth()/2 - (self.tileWidth*self.MapWidth)/2
    local mapOffsetY = love.graphics.getHeight()()/2 - (self.tileWidth* math.ceil(#self.map / self.MapWidth) )/2

    for i, v in ipairs(self.map) do
        love.graphics.rectangle("fill", math.fmod(i-1,self.MapWidth)*(self.TileWidth - 2) + mapOffsetX ,math.floor((i-1)/self.MapWidth)*(self.TileHeight-2) + mapOffsetY, self.tileWidth, self.tileWidth)
    end


end

return Level