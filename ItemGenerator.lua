class = require("Lib.30log")
require("ItemPool")
require("Items.Armor")
require("Items.Weapon")

ItemGenerator = class("ItemGen", {spawn_limit, tile_map})
function ItemGenerator:init(spawn_limit, tile_map)
  self.map = tileMap
  self.limit = spawn_limit
  self.count = 0
  self.pool = ItemPool:new()
  self.items = {}
  
  for i = 1, self.limit do
    local type = self.pool.item_types[math.random(1, #self.pool.item_types)]
    self:spawn(type)
  end
end

function ItemGenerator:spawn(type)
  local new_item = self:get_item(type)
  local spawn_pos = self.map:get_rand_tile()
  new_item:set_pos(spawn_pos.point.x, spawn_pos.point.y)
  table.insert(self.items, new_item)
  self.map:add_item(spawn_pos.point.x, spawn_pos.point.y, new_item)
  self.count = self.count + 1
end


function ItemGenerator:get_item(type)
  if type == "Armor" then
    local armor_type = self.pool:get_armor()
    local armor = Armor
    return Armor:new(armor_type[1], armor_type[2], armor_type[3], armor_type[4], armor_type[5])
  elseif type == "Weapon" then
    local weapon_type = self.pool:get_weapon()
    return Weapon:new(weapon_type[1], weapon_type[2], weapon_type[3], weapon_type[4], weapon_type[5])
  end
end

