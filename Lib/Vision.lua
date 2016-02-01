class = require("Lib.30log")

Vision = class("Vision", {})
  function Vision:init()
  end

  function Vision:check(x1,y1,x2,y2, tile_map)
    if caller.id == "player" then
      self:player_sight(x1,y1,x2,y2, tile_map )
    end
    
    if caller.id == "enemy" then
      self:enemy_sight(x1,y1,x2,y2, tile_map)
    end
  end



  function Vision:cast_line(x1,y1,x2,y2, ent, tile_map)
    points={} 
      
    dx = math.abs(x2-x1) 
    dy = math.abs(y2-y1) 
    sx = x1<x2 and 1 or -1 
    sy = y1<y2 and 1 or -1 
    err = dx-dy
    dist = ent.distance or 5
 
    while true do 
      table.insert(points, {x1, y1}) 
      if x1==x2 and y1==y2 then break end 
      local e2=err*2 
      if e2>-dx then 
        err=err-dy 
        x1 = x1+sx 
      end 
      if e2<dx then 
        err = err+dx 
        y1 = y1+sy
      end
      if #points == dist then
        break
      end
    end 

    for i = 1, #points do
      local x = points[i][1]
      local y = points[i][2]
    end
  end
  
  
  
  
  function Vision:calculateVisibility(x,y, tile_map)
    local tx, ty = x,y

    for i = 1, 360 do
        local ox, oy = tx + 0.5, ty + 0.5;
        local rad = math.rad(i);
        local rx, ry = math.cos(rad), math.sin(rad);

      for i = 1, 12 do
        if tile_map:get_tile(math.floor(ox), math.floor(oy)) then
          local target = {}
          target.x = math.floor(ox)
          target.y = math.floor(oy)

          if tile_map:get_type(target.x, target.y) == "wall" then
            tile_map:set_discovered(target.x, target.y)
            tile_map:add_lit_tile(tile_map:get_tile(target.x, target.y))
            break
          else
            tile_map:set_discovered(target.x, target.y)
            tile_map:add_lit_tile(tile_map:get_tile(target.x, target.y))
            ox = ox + rx;
            oy = oy + ry;
          end
        end
      end
    end
  end
  
  
  
  
  function Vision:enemy_sight(x1,y1,x2,y2, enemy, tiles)
    points={} 
    
    dx = math.abs(x2-x1) 
    dy = math.abs(y2-y1) 
    sx = x1<x2 and 1 or -1 
    sy = y1<y2 and 1 or -1 
    err = dx-dy 
 
    while true do 
      table.insert(points, {x1, y1}) 
      if x1==x2 and y1==y2 then break end 
      local e2=err*2 
      if e2>-dx then 
        err=err-dy 
        x1 = x1+sx 
      end 
      if e2<dx then 
        err = err+dx 
        y1 = y1+sy
      end
      if #points == enemy.view_distance then
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
          enemy.target = tiles:get_entity(x,y)
          if i == enemy.melee_range + 1 then
            enemy.in_melee_range = true
          else
            enemy.in_melee_range = false
          end
          break
        else
          enemy.target = nil
        end
      end
    end
  end