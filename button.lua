local Object = require "classic"
local Button = Object:extend()


function Button:new(text, x, y, w, h, action, font)
    self.text = text
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.action = action
    self.font = font
end

function Button:render()
    love.graphics.setColor(0.8,0.1,0.1)
    love.graphics.rectangle("fill", self.x,self.y,self.w,self.h)
    love.graphics.setColor(1,1,1)
    love.graphics.setFont(self.font)
    local textWidth = self.font:getWidth(self.text)
    local textHeight = self.font:getHeight(self.text)
    love.graphics.print(self.text, self.x + (self.w / 2) - (textWidth / 2),
    self.y + (self.h / 2) - (textHeight / 2))
end

function Button:checkPressed(x,y)
    if x >= self.x and x <= self.x + self.w and
           y >= self.y and y <= self.y + self.h then
            SelectSfx:play()
            self.action()
            -- Here we will switch back to the main menu
            return
        end
end

return Button