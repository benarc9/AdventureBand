class = require("Lib.30log")
require("Entites.Entity")
require("Lib.Vision")

Player = Entity:extend("Player", {name, image_path, lvl, hp, att, def, speed})
  function Player:init(name, image_path, lvl, hp, att, def, speed)
    Player.super.init(self, "Player")
    self.name = "Finn"
    self.id = "player"
    self.image_path = image_path
    self.image = love.graphics.newImage(image_path)
    
    self.inventory = nil
    
    self.lvl = 1
    self.exp = 0
    self.exp_to_next = 100
    
    self.base_speed = 2
    self.base_hp = 45
    self.base_att = 8
    self.base_def = 4
    self.base_vd = 5
    
    self.curr_def = self.base_def
    self.curr_hp = self.base_hp
    self.curr_att = self.base_att
    self.curr_speed = self.base_speed
    self.curr_vd = self.base_vd
    
    self.stats = {}
      self.stats.magic    =  0
      self.stats.charis   =  8
      self.stats.strength =  9
      self.stats.agility  =  5
      self.stats.sight    =  5
      self.stats.speed    =  2
      self.stats.accur    =  9
      
    self.invent = {}
      self.invent.armor = {}
      self.invent.weapons = {}
      self.invent.key = {}
      self.invent.item = {}
    
    self.slots = {}
      self.slots.head = {}
        self.slots.head.item = nil
        self.slots.head.pos = {}
          self.slots.head.pos.x = nil
          self.slots.head.pos.y = nil
      self.slots.r_hand = {}
        self.slots.r_hand.item = nil
      self.slots.l_hand = {}
        self.slots.l_hand.item = nil
      self.slots.shirt = {}
        self.slots.shirt.item = nil
      self.slots.shorts = {}
        self.slots.shorts.item = nil
      self.slots.legs = {}
        self.slots.legs.item = nil
      self.slots.feet = {}
        self.slots.feet.item = nil
      self.slots.fingers = {}
        self.slots.fingers.fing_1 = {}
          self.slots.fingers.fing_1.item = nil
        self.slots.fingers.fing_2 = {}
          self.slots.fingers.fing_2.item = nil

    self.d_target = {}
    
    self.vision = Vision:new("Player_Vision", {})
  end
  
  
  
  function Player:spawn(room_count, rooms, tile_map)
    local spawn_room = math.random(1, room_count)
    self:set_pos(rooms[spawn_room].pos.x, rooms[spawn_room].pos.y)
    tile_map:add_entity(rooms[spawn_room].pos.x, rooms[spawn_room].pos.y, self)
  end
  
  
  
  function Player:update(tile_map, tileWidth, tileHeight)
    self:set_pos(self.point.x, self.point.y)
    local update = nil
    update = self:input(tile_map)
    self:sight_check(tile_map, tileWidth, tileHeight)
  end
  
  function Player:gui_init(inventory)
    self.inventory = inventory
  end
  
  function Player:att_melee(enemy)
    enemy:damage(self.curr_att)
  end
  
  function Player:equip_item(item)
    item:stat_adj(self)
  end
  
  function Player:damage(power)
    if power - self.curr_def < 0 then
      self.curr_hp = self.curr_hp - 1
    else
      self.curr_hp = self.curr_hp - (power - self.curr_def)
    end
  end
  
  function Player:pick_up(item)
    table.insert(self.invent, item)
  end
  
  function Player:move(direction, tile_map)
    self.d_target.x = direction.x
    self.d_target.y = direction.y
  
    local target = {}
    target[0] = self.point.x + direction.x
    target[1] = self.point.y + direction.y
    
    local old_tile = {}
    old_tile.x = self.point.x
    old_tile.y = self.point.y
  
    if tile_map:is_traversable(target[0], target[1]) then
      self:set_pos(target[0], target[1])
      tile_map:remove_ent(old_tile.x, old_tile.y)
      tile_map:add_entity(target[0], target[1], self)
    elseif tile_map:is_occupied(target[0], target[1]) then
      if tile_map:get_entity(target[0], target[1]).entity_type == "enemy" then
        self:att_melee(tile_map:get_entity(target[0], target[1]))
      end
    end
  end
  
  
  
  function Player:input(tile_map, main)
    
    function love.keypressed(k)
      update = true
    
      local dir = {}
      dir.x = 0
      dir.y = 0
      
      if k == "w" then
        dir.x = 0
        dir.y = -1
      elseif k == "x" then
        dir.x = 0
        dir.y = 1
      elseif k == "a" then
        dir.x = -1
        dir.y = 0
      elseif k == "d" then
        dir.x = 1
        dir.y = 0
      elseif k == "e" then
        dir.x = 1
        dir.y = -1
      elseif k == "q" then
        dir.x = -1
        dir.y = -1
      elseif k == "c" then
        dir.x = 1
        dir.y = 1
      elseif k == "z" then
        dir.x = -1
        dir.y = 1
      elseif k == "s" then
        --wait for 1 turn
      elseif k == "g" then
        self:pick_up(tile_map)
      else
        return true
      end
      self:move(dir, tile_map)
      return false
    end
  end

  function Player:pick_up(tile_map)
    local item = tile_map:get_item(self.point.x, self.point.y)
    if item then
      self.inventory:add_item(self, item)
      item:pick_up()
    end
  end

  
  
  
  function Player:sight_check(tile_map, tileWidth, tileHeight)
    self.vision:calculateVisibility(self.point.x, self.point.y, tile_map)
  end
  