class = require("Lib.30log")

ItemPool = class("ItemPool", {})
function ItemPool:init()
  self.item_types = {
                      "Armor",
                      "Weapon"
                    }
                    
  self.armor_types = {}
    self.armor_types[1] = {"IceCrown",
                           "armor",
                           {
                             love.graphics.newImage("Images/Items/IceCrown/ground.png"),
                             love.graphics.newImage("Images/Items/IceCrown/invent.png"),
                             love.graphics.newImage("Images/Items/IceCrown/equip.png")
                           },
                           "head",
                           {0, -130}
                          }
    
  self.weapon_types = {}
    self.weapon_types[1] = {"Classic",
                            "weapon",
                             {
                              love.graphics.newImage("Images/Items/Sword_1/ground.png"),
                              love.graphics.newImage("Images/Items/Sword_1/invent.png"),
                              love.graphics.newImage("Images/Items/Sword_1/equip.png")
                             },
                             "right_hand",
                             {29, -80}
                           }
end

function ItemPool:get_armor()
  local armor = self.armor_types[math.random(1, #self.armor_types)]
  return armor
end

function ItemPool:get_weapon()
  local weapon = self.weapon_types[math.random(1, #self.weapon_types)]
  return weapon
end


