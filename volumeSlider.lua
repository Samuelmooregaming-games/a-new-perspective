local Object = require "classic"
local VSlider = Object:extend()

local movingSldier = false

function VSlider:new(x,y,startValue)
    self.parentX = x
    self.parentY = y
    self.parentWidth = 200
    self.parentHeight = 10
    self.childWidth = 10
    self.childHeight = 30
    self.value = startValue
    self.childX = self.parentWidth*self.value + (self.parentX - self.parentWidth/2)
    self.childY = self.parentY
    
end

function VSlider:Update(dt)

    --checking for mouse grabing slider
    local mouseX, mouseY = love.mouse.getPosition()
    if love.mouse.isDown(1) then

        if mouseX > self.parentX - self.parentWidth/2 and mouseX < self.parentX + self.parentWidth/2 then
            if mouseY > self.childY - self.childHeight/2 and mouseY < self.childY + self.childHeight/2 then
                movingSldier = true
            end
        end
    else
        movingSldier = false
    end

    -- slider movement logic
    if movingSldier == true then
        if mouseX < self.parentX - self.parentWidth/2 then
            self.childX = self.parentX - self.parentWidth/2
        elseif mouseX > self.parentX + self.parentWidth/2 then
            self.childX = self.parentX + self.parentWidth/2
        else
            self.childX = mouseX
        end
        
        self.value = (self.childX - (self.parentX - self.parentWidth/2))/self.parentWidth

    end

    --setting volume
    love.audio.setVolume(self.value)


end

function VSlider:render()
    love.graphics.setColor(0.6,0.6,0.6)
    love.graphics.rectangle("fill",self.parentX - self.parentWidth/2,self.parentY - self.parentHeight/2,self.parentWidth,self.parentHeight)
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("fill",self.childX - self.childWidth/2,self.childY - self.childHeight/2,self.childWidth,self.childHeight)

    local labelText = "Volume"
    local labelFont = love.graphics.newFont(20)
    local labelTextWidth = labelFont:getWidth(labelText)
    love.graphics.setFont(labelFont)
    love.graphics.print(labelText,self.parentX - labelTextWidth/2, self.parentY - 40)

end


return VSlider