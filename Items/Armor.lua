class = require("Lib.30log")
require("Items.Item")

Armor = Item:extend("Armor", {id, type, images, slot, img_off})
function Armor:init(id, type, images, slot, img_off)
  
  self.test = id
  

  Armor.super.init(self, id, type, images, slot, img_off)
  

end

function Armor:on_equip()
  
end

function Armor:on_remove()
  
end

function Armor:give_bonus()
  
end
