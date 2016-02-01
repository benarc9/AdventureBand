class = require("Lib.30log")
require("Items.Item")

Weapon = Item:extend("Weapon", {id, type, images, slot, img_off})
function Weapon:init(id, type, images, slot, img_off)
  
  self.test = id

  Weapon.super.init(self, id, type, images, slot, img_off)
end