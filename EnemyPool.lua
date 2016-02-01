class = require("Lib.30log")
require("Enemies.Slime")

EnemyPool = class("EnemyPool", {})
function EnemyPool:init()
  self.enemies = {
                  Slime
                 }
end

function EnemyPool:get_rand_enemy()
  local new_enemy = self.enemies[math.random(1, #self.enemies)]
  return new_enemy
end