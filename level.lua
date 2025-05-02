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

local Button = require "button"

local backButton1 = Button("Back",3,5,75,50,function() ChangeScreen(2) end, love.graphics.newFont(20),{1,1,1},{0.8,0.1,0.1})
local backButton2 = Button("Level Select",SCREEN_WIDTH/2 - 75,SCREEN_HEIGHT/2,150,50,function() ChangeScreen(2) end, love.graphics.newFont(20),{1,1,1},{0.8,0.1,0.1})

local winRectangle = {x = 150,y =150,width = 500,height = 250}

function Level:new(map,mapWidth)
     self.super.new()
     self.map = map
     self.mapWidth = mapWidth
     self.tileWidth = 32
     self.completed = false
     self.onWinTile = false
     self.onDeathTile = false
     self.button = {}
     self.player = {}
     self.exit = {}
     self.deathbutton = {}
     self.exitRevealed = false
     self.remainingJumps = 5


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
        elseif v == 3 or v == 6 then
            self.exit.x = math.fmod(i - 1, self.mapWidth)
            self.exit.y = math.floor((i - 1) / self.mapWidth)
        elseif v == 7 or v == 8 then
            table.insert(self.deathbutton, {
                x = math.fmod(i - 1, self.mapWidth),
                y = math.floor((i - 1) / self.mapWidth)
            })
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
        
    elseif v == 6 then
        if revealing then
            love.graphics.setColor(.83, .68, .21) -- revealed exit = Gold
            love.graphics.draw(self.ExitTexture, tileX, tileY,0,.125,.125)
        else
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(self.WallTexture, tileX, tileY,0,.125,.125)
        end

    elseif v == 7 then
        if revealing then
            love.graphics.setColor(0.8, 0.1, 0.1)  -- death walls = light red when revealed
            love.graphics.draw(self.WallTexture, tileX, tileY,0,.125,.125)
        else
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(self.WallTexture, tileX, tileY,0,.125,.125)
        end
    elseif v == 8 then
        if revealing then
            love.graphics.setColor(0.8, 0.1, 0.1)  -- death walls = light red when revealed
            love.graphics.draw(self.FloorTexture, tileX, tileY,0,.125,.125)
        else
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(self.FloorTexture, tileX, tileY,0,.125,.125)
        end
    elseif v == 9 then
        if revealing then
            love.graphics.setColor(.6, .2, .6) -- revealed exit = Gold
            love.graphics.draw(self.ExitTexture, tileX, tileY,0,.125,.125)
        else
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(self.FloorTexture, tileX, tileY,0,.125,.125)
        end
    
    end
    end
    
    if not self.player.x or not self.player.y then
        error("Player start (tile 1) not found in the map!")
    end

     love.graphics.setColor(1,1,1)
     love.graphics.draw(self.PlayerTexture, quads[math.floor(Currentquad)], (self.player.x*self.tileWidth) + mapOffsetX,  (self.player.y*self.tileWidth) + mapOffsetY )
    

    backButton1:render()

    -- ui for jumps
     love.graphics.setColor(1, 1, 1)
     local jumpFont = love.graphics.newFont(18)
     love.graphics.setFont(jumpFont)
     local jumpText =  "Hold \n\n TAB \n\n to \n jump \n\n Jumps \n left: ".. tostring(self.remainingJumps)
     love.graphics.print(jumpText, love.graphics.getWidth() - 75, 20)
     
    
    if self.onWinTile then

        --win popup
        love.graphics.setColor(0, 0.7, 0) 
        love.graphics.rectangle("fill",winRectangle.x,winRectangle.y,winRectangle.width,winRectangle.height)
        local winFont = love.graphics.newFont(30)
        love.graphics.setFont(winFont)
        local winText = "YOU WIN!"
        local winTextWidth = winFont:getWidth(winText)
        local winTextHeight = winFont:getHeight(winText)
        love.graphics.setColor(1, 1, 1) 
        love.graphics.print("YOU WIN",
            winRectangle.x + (winRectangle.width / 2) - (winTextWidth / 2),
            winRectangle.y + (winRectangle.height / 2) - (winTextHeight / 2) - 50
        )


        backButton2:render()
    end

end

function Level:Update(dt)
    self.super.Update(dt)


    if self.player.x == self.button.x and self.player.y == self.button.y then
        self.exitRevealed = true
    end

   -- self.onDeathTile = false
for _, pos in ipairs(self.deathbutton) do
    if self.player.x == pos.x and self.player.y == pos.y then
        self.onDeathTile = true
        break
    end
end

    if self.onDeathTile == true then 
        self:Reset()
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
     self.onDeathTile = false
     self.remainingJumps = 5 

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

    -- player movement refactored to get jump movement and checks 
    local dx, dy = 0, 0
    if key == "a" then dx = -1
    elseif key == "d" then dx = 1
    elseif key == "w" then dy = -1
    elseif key == "s" then dy = 1
    else return end  
     
    local moveSpeed = love.keyboard.isDown("tab") and 2 or 1

    local function getTile(x, y)
        if x < 0 or x >= self.mapWidth or y < 0 or y >= math.ceil(#self.map / self.mapWidth) then
            return 4  -- Treat out-of-bounds as wall
        end
        return self.map[(y * self.mapWidth) + x + 1]
    end


     local nextX = self.player.x + dx
     local nextY = self.player.y + dy

    if moveSpeed == 2 then
        if self.remainingJumps > 0 then
          local midX = self.player.x + dx
          local midY = self.player.y + dy
          local endX = self.player.x + dx * 2
          local endY = self.player.y + dy * 2

          local midTile = getTile(midX, midY)
          local endTile = getTile(endX, endY)

        if midTile ~= 4 and endTile ~= 4 then
            if Step:isPlaying() == true then
                Step:stop()
            end
            Step:play()
            self.player.x = endX
            self.player.y = endY
            self.remainingJumps = self.remainingJumps - 1 
        end
    end
    else
        local targetTile = getTile(nextX, nextY)
        if targetTile ~= 4 then
            if Step:isPlaying() == true then
                Step:stop()
            end
            Step:play()
            self.player.x = nextX
            self.player.y = nextY

        end
    end

end

function Level:mousepressed(x, y, button)
    self.super.mousepressed()
    if button == 1 then

        if self.onWinTile then
            backButton2:checkPressed(x,y)
        end

        backButton1:checkPressed(x,y)

    end
end


return Level

