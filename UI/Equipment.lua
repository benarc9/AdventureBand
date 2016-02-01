class = require("Lib.30log")

Equipment = class("Equip", {ui, id, gui, player})
function Equipment:init(ui, id, gui, player)
  self.id = id
  self.char_image = love.graphics.newImage("Images/UI/equipment_finn.png")
  
  self.gui = gui
  
  self.panel = ui.Create("panel")
    self.panel.Draw = function() end
    self.panel:SetPos(1000, 150)
  
  self.equip_image = ui.Create("image", self.panel)
    self.equip_image:SetPos(0,0)
    self.equip_image:SetImage(self.char_image)
    
    
  self.boxes = {}
    self.boxes.head = ui.Create("imagebutton")
      self.boxes.head:SetPos(1036,156)
      self.boxes.head:SetSize(86,66)
      self.boxes.head:SetText("")
      self.boxes.head.OnClick = function()
        self.gui.panels.invent:open_tab("armor")
      end
      
    self.boxes.chest = ui.Create("imagebutton")
      self.boxes.chest:SetPos(1035,224)
      self.boxes.chest:SetSize(85,77)
      self.boxes.chest.Draw = function() end
      local inventory = self.inventory
      self.boxes.chest.OnClick = function()
        self.gui.panels.invent:open_tab("armor")
      end
      
    self.boxes.shorts = ui.Create("imagebutton")
      self.boxes.shorts:SetPos(1033,304)
      self.boxes.shorts:SetSize(87,40)
      self.boxes.shorts.Draw = function() end
      self.boxes.shorts.OnClick = function()
        self.gui.panels.invent:open_tab("weapons")
      end
      
    self.boxes.legs = ui.Create("imagebutton")
      self.boxes.legs:SetPos(1032,348)
      self.boxes.legs:SetSize(89,66)
      self.boxes.legs.Draw = function() 
        
      end
      
    self.boxes.feet = ui.Create("imagebutton")
      self.boxes.feet:SetPos(1035,415)
      self.boxes.feet:SetSize(121,29)
      self.boxes.feet.Draw = function() 
      
      end
    
    self.boxes.left_hand = ui.Create("imagebutton")
      self.boxes.left_hand:SetPos(1005,224)
      self.boxes.left_hand:SetSize(15,77)
      self.boxes.left_hand:SetText("")
      self.boxes.left_hand.OnClick = function ()
        self.gui.panels.invent:open_tab("weapons")
      end
      
    self.boxes.right_hand = ui.Create("imagebutton")
      self.boxes.right_hand:SetPos(1125,224)
      self.boxes.right_hand:SetSize(50,77)
      self.boxes.right_hand:SetText("")
      self.boxes.right_hand.OnClick = function ()
        self.gui.panels.invent:open_tab("weapons")
      end
      
    self.images = {}
      self.images.head = nil
      self.images.chest = nil
      self.images.shorts = nil
      self.images.legs = nil
      self.images.feet = nil
      self.images.r_hand = nil
      self.images.l_hand = nil
end




function Equipment:get_id()
  return self.id
end


function Equipment:equip_item(item)
  if item.slot == "right_hand" then
    self.images.r_hand = ui.Create("image")
    self.images.r_hand:SetImage(item.images.equip)
    self.images.r_hand:SetPos(self.boxes.right_hand:GetX() + item.offset[1], self.boxes.right_hand:GetY() + item.offset[2])
  elseif item.slot == "head" then
    self.images.head = ui.Create("image")
    self.images.head:SetImage(item.images.equip)
    self.images.head:SetPos(self.boxes.head:GetX() + item.offset[1], self.boxes.right_hand:GetY() + item.offset[2])
  elseif item.slot == "left_hand" then
    self.images.l_hand = ui.Create("image")
    self.images.l_hand:SetImage(item.images.equip)
    self.images.l_hand:SetPos(self.boxes.left_hand:GetX() + item.offset[1], self.boxes.right_hand:GetY() + item.offset[2])
  end
end

