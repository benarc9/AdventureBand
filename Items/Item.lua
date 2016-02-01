class = require("Lib.30log")

Item = class("Item", {id, type, images, slot, img_off})
function Item:init(id, type, images, slot, img_off)
  self.id = id
  
  self.images = {}
    self.images.ground = images[1]
    self.images.invent = images[2]
    self.images.equip  = images[3]

  self.pos = {}
    self.pos.x = nil
    self.pos.y = nil
    
  self.type = type
  
  self.slot = slot
  
  self.on_ground = true
  
  self.offset = img_off
  
end



function Item:pick_up()
  self.on_ground = false
end

function Item:get_id()
  return self.id
end

function Item:get_images(x,y)
  return self.images
end

function Item:get_pos()
  return self.pos
end

function Item:set_pos(x,y)
  self.pos.x = x
  self.pos.y = y
end

function Item:use(player)
  if self.type == "armor" or self.type == "Armor" then
    
  end
end





