
local Object = require "classic"
local Screen = Object:extend()

function Screen:new()

    --self.Canvas = love.graphics.newCanvas(SCREEN_WIDTH,SCREEN_HEIGHT)

end

function Screen:Update(dt)
end

function Screen:DrawScreen()
end

function Screen:Keypressed(key)
end

function Screen:Reset()
end

function Screen:MousePressed(x,y,button)
end

return Screen