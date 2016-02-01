class = require("Lib.30log")
require("Enemy")
require("EnemyPool")

EnemySpawner = class("EnemySpawner", {tileMap, enemy_limit})
function EnemySpawner:init(tileMap, enemy_limit)
  self.map = tileMap
  self.limit = enemy_limit
  self.count = 0
  self.pool = EnemyPool:new()
  self.enemies = {}
  
  for i = 1, self.limit do
    self:spawn()
  end
end


function EnemySpawner:spawn()
    local new_enemy = self.pool:get_rand_enemy():new()
    local spawn_pos = self.map:get_rand_tile()
    new_enemy.point.x = spawn_pos.point.x
    new_enemy.point.y = spawn_pos.point.y
    new_enemy:set_pos(spawn_pos.point.x, spawn_pos.point.y)
    self.map:add_entity(spawn_pos.point.x, spawn_pos.point.y, new_enemy)
    table.insert(self.enemies, new_enemy)
    self.count = self.count + 1
end

function EnemySpawner:get_enemy_type()
  
end

function EnemySpawner:get_enemies()
  return self.enemies
end

function EnemySpawner:get_enemy(index)
  return self.enemies[index]
end

function EnemySpawner:update(player)
  if self.count > 0 then
    for i = 1, #self.enemies do
      local dead = nil
      if self.enemies[i] then
        dead = self.enemies[i]:update(self.enemies, self.map, i, player)
        if dead then
          self.map:remove_ent(self.enemies[i].point.x, self.enemies[i].point.y)
          table.remove(self.enemies, i)
        end
      end
    end
  else
    return
  end
end

  


