class = require("Lib.30log")
require("Entites.Entity")

Enemy = Entity:extend("Enemy", {name, image_path, hp, mp, att, att_mod, def, speed, mv_speed, view_distance, melee_range, dist_range})
  function Enemy:init(name, image_path, hp, mp, att, att_mod, def, speed, mv_speed, view_distance, melee_range, dist_range)
    Enemy.super.init(self, "enemy")
    self.name = name
    self.id = "enemy"
    self.image_path = image_path
    self.debug_image = love.graphics.newImage("Images/Tiles/fog_01.png")
    
    self.base_hp = hp
    self.base_mp = mp
    self.base_att = att
    self.base_def = def
    self.base_speed = speed
    self.base_mv_speed = mv_speed
    
    self.curr_hp = self.base_hp
    self.curr_mp = self.base_mp
    self.curr_att = self.base_att
    self.curr_def = self.base_def
    self.curr_speed = self.base_speed
    self.curr_mv_speed = self.base_mv_speed
    
    self.att_mod = att_mod
    self.melee_range = melee_range
    self.dist_range = dist_range
    
    self.view_distance = view_distance
    
    self.target         = nil
    self.image          = nil
    self.in_melee_range = false
    
    self.visible = nil
    self.last_seen_position = {}
    
    
    
    if self.image_path then
      self.image = love.graphics.newImage(image_path)
    else
      self.image = nil
    end
  end
  

  function Enemy:damage(power)
    self.curr_hp = self.curr_hp - (power - self.curr_def)
  end



  function Enemy:update(enemies, tiles, index, player, file)
    self:set_pos(self.point.x, self.point.y)
    if self.curr_hp <= 0 then
      return true
    end
    
    self:check_sight(self.point.x, self.point.y, 
                     player.point.x, player.point.y, 
                     tiles
                    )
                    
    if self.target then
      if self.in_melee_range == false then
        self:chase(tiles)
      else
        self:att()
      end
    else
      self:idle(tiles)
    end
    
    if tiles:get_overlay(self.point.x, self.point.y) == nil then
      self.visible = true
      self.last_seen_position.x = self.pos.x
      self.last_seen_position.y = self.pos.y
    else
      self.visible = false
    end
    return false
  end
  
  
  
  function Enemy:idle(tiles)
    decision = math.random(0, 1)
    if decision > .5 then
      x_dir = math.random(0,1)
      y_dir = math.random(0,1)
      if x_dir > .5 then
        x_mod = 1
      else
        x_mod = -1
      end
      if y_dir > .5 then
        y_mod = 1
      else
        y_mod = -1
      end
      self:move(x_mod, y_mod, tiles)
    elseif decision <= .5 then
      --skip turn
    end
        
  end
  
  
  function Enemy:move(x_mod, y_mod, tiles)
    if tiles:is_traversable(self.point.x + (x_mod * self.curr_mv_speed), self.point.y + (y_mod * self.curr_mv_speed)) == true then
      tiles:remove_ent(self.point.x, self.point.y)
      tiles:add_entity(self.point.x + (x_mod * self.curr_mv_speed), self.point.y + (y_mod * self.curr_mv_speed), self)
      self:set_pos(self.point.x + (x_mod * self.curr_mv_speed), self.point.y + (y_mod * self.curr_mv_speed))
    end
  end
  
  
  
  function Enemy:chase(tiles)
    x_mod = 0
    y_mod = 0
    
      
      if self.target.point.x == self.point.x then
        if self.point.y < self.target.point.y then
          y_mod = 1
        else
          y_mod = -1
        end
      elseif self.target.point.y == self.point.y then
        if self.point.x < self.target.point.x then
          x_mod = 1
        else
          x_mod = -1
        end
      else
        if self.point.x < self.target.point.x then
          x_mod = 1
        else
          x_mod = -1
        end
        
        if self.point.y < self.target.point.y then
          y_mod = 1
        else
          y_mod = -1
        end
      end
      self:move(x_mod, y_mod, tiles)
  end
  
  
  
  function Enemy:check_sight(x1, y1, x2, y2, tiles) 
    points={} 
    
    self.x1 = x1
    self.y1 = y1
    self.x2 = x2
    self.y2 = y2
    
    dx = math.abs(self.x2-self.x1) 
    dy = math.abs(self.y2-self.y1) 
    sx = self.x1<self.x2 and 1 or -1 
    sy = self.y1<self.y2 and 1 or -1 
    err = dx-dy 
 
    while true do 
      table.insert(points, {self.x1, self.y1}) 
      if self.x1==self.x2 and self.y1==self.y2 then break end 
      local e2=err*2 
      if e2>-dx then 
        err=err-dy 
        self.x1 = self.x1+sx 
      end 
      if e2<dx then 
        err = err+dx 
        self.y1 = self.y1+sy
      end
      if #points == self.view_distance then
        break
      end
    end
    
    for i = 1, #points do
      local x = points[i][1]
      local y = points[i][2]
      
      if tiles:get_type(x,y) == "wall" then
        break
      end
      if tiles:get_entity(x,y) then
        if tiles:get_entity(x,y).entity_type == "Player" then
          self.target = tiles:get_entity(x,y)
          if i == self.melee_range + 1 then
            self.in_melee_range = true
          else
            self.in_melee_range = false
          end
        else
          self.target = nil
        end
      end
    end
  end

  
  
  function Enemy:round(num, idp)
      local mult = 10^(idp or 0)
      return math.floor(num * mult + 0.5) / mult
  end
  
  
  
  function Enemy:att()
    self.target:damage(self:att_roll())
  end
  
  
  
  function Enemy:att_roll()
    att = math.random(
                      self.curr_att - self.att_mod, 
                      self.curr_att + self.att_mod
                      )
    return att
  end


  
