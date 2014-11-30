local splashes={
  ["time"]=0 -- Time since began
}
splashes.__index=splashes
function love.load(t)

end
function love.update(dt)
  self=splashes
  self.time=self.time+dt
  if self.time > 12 then require "game" end
  if self.time > 8 and self.time < 9 and not assets.eijingle:isPlaying() then
    assets.eijingle:play()
  end
end
function love.draw()
  self=splashes
  if self.time < 4 then
    love.graphics.draw(assets.lua,100,0,0,4.75,4.75)
  elseif self.time < 8 then
    love.graphics.draw(assets.love,135,60)
  elseif self.time < 12 then
    love.graphics.draw(assets.eilogo)
  end
end
function love.mousepressed(x, y, button)
end
function love.mousereleased(x, y, button)

end
function love.focus(f)

end
function love.quit()

end
return splashes