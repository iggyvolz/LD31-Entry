local self={
  ["people"]={

  },
  ["algore"]={
    ["x"]=400,
    ["y"]=400,
    ["width"]=20,
    ["height"]=70,
    ["speed"]=250
  },
  ["time"]=0,
  ["nextspawntime"]=0,
  ["votes"]={
    ["gore"]=0,
    ["bush"]=0
  }
}
self.__index=self
function self.algore.isHitting(i)
  if not self.people[i].active then return false end
  if self.people[i].x>self.algore.x+self.algore.width then return false end
  if self.people[i].x+self.people[i].width<self.algore.x then return false end
  if self.people[i].y>self.algore.y+self.algore.height then return false end
  if self.people[i].y+self.people[i].height<self.algore.y then return false end
  return true
end
function self.convince(i,v) -- i = person, v = how much
  if not self.people[i] then return end
  if self.people[i].cg==1 then return end
  if self.people[i].cg>1-v then self.people[i].cg=1 return end
  self.people[i].cg=self.people[i].cg+v
end
function self.choose(i)
  return math.random()<self.people[i].cg
end
function self.go()
  function love.load(t)

  end
  function love.update(dt)
    if self.algore.hitting then self.convince(self.algore.hitting,0.125*dt) end
    self.time=self.time+dt
    local oldx=self.algore.x
    local oldy=self.algore.y
    if love.keyboard.isDown("s") or love.keyboard.isDown("down") then
      self.algore.hitting=nil
      if self.algore.y-10+self.algore.height+self.algore.speed*dt>600 then
        self.algore.y=540
      else
        self.algore.y=self.algore.y+self.algore.speed*dt
      end
    elseif love.keyboard.isDown("w") or love.keyboard.isDown("up") then
      self.algore.hitting=nil
      if self.algore.y-10-self.algore.speed*dt<0 then
        self.algore.y=10
      else
        self.algore.y=self.algore.y-self.algore.speed*dt
      end
    end
    if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
      self.algore.hitting=nil
      if self.algore.x-(self.algore.width/2)-self.algore.speed*dt<0 then
        self.algore.x=10
      else
        self.algore.x=self.algore.x-self.algore.speed*dt
      end
    elseif love.keyboard.isDown("d") or love.keyboard.isDown("right") then
      self.algore.hitting=nil
      if self.algore.x+(self.algore.width/2)+self.algore.speed*dt>800 then
        self.algore.x=790
      else
        self.algore.x=self.algore.x+self.algore.speed*dt
      end
    end
    for i=1,#self.people do
      if self.people[i].active then
        local hit=self.algore.isHitting(i)
        if hit then -- Get Al Gore of the way
          self.algore.x=oldx
          self.algore.y=oldy
          self.algore.hitting=i
        end
        if self.people[i].choosetime<self.time then
          if self.choose(i) then
            self.votes.gore=self.votes.gore+1
          else
            self.votes.bush=self.votes.bush+1
          end
          self.people[i].active=false
        end
      end
    end
    if self.time<self.nextspawntime then return end
    self.people[#self.people+1]={["cg"]=math.random(65)/100,["active"]=false,["x"]=math.random(780),["y"]=math.random(530),["height"]=70,["width"]=20,["active"]=true,["choosetime"]=self.time+5}
    while self.algore.isHitting(#self.people) do
      self.people[#self.people].x=math.random(780)
      self.people[#self.people].y=math.random(530)
    end
    self.nextspawntime=3+self.time
  end
  function love.draw()
    love.graphics.setFont(font(12))
    love.graphics.setColor(0,0,0)
    love.graphics.print(self.votes.gore.." GORE, "..self.votes.bush.." BUSH",0,0)
    for i=1,#self.people do
      if self.people[i].active then
        love.graphics.setColor(255*(1-self.people[i].cg),0,255*self.people[i].cg)
        love.graphics.circle("line",self.people[i].x,self.people[i].y,10)
        love.graphics.line(self.people[i].x,self.people[i].y+10,self.people[i].x,self.people[i].y+40)
        love.graphics.line(self.people[i].x,self.people[i].y+40,self.people[i].x-10,self.people[i].y+60)
        love.graphics.line(self.people[i].x,self.people[i].y+40,self.people[i].x+10,self.people[i].y+60)
        love.graphics.line(self.people[i].x,self.people[i].y+25,self.people[i].x+10,self.people[i].y+15)
        love.graphics.line(self.people[i].x,self.people[i].y+25,self.people[i].x-10,self.people[i].y+15)
      end
    end
    love.graphics.setColor(0,0,0)
    love.graphics.circle("line",self.algore.x,self.algore.y,10)
    love.graphics.line(self.algore.x,self.algore.y+10,self.algore.x,self.algore.y+40)
    love.graphics.line(self.algore.x,self.algore.y+40,self.algore.x-10,self.algore.y+60)
    love.graphics.line(self.algore.x,self.algore.y+40,self.algore.x+10,self.algore.y+60)
    love.graphics.line(self.algore.x,self.algore.y+25,self.algore.x+10,self.algore.y+15)
    love.graphics.line(self.algore.x,self.algore.y+25,self.algore.x-10,self.algore.y+15)
  end
  function love.mousepressed(x, y, button)
  end
  function love.mousereleased(x, y, button)

  end
  function love.focus(f)

  end
  function love.quit()

  end
end
return self
