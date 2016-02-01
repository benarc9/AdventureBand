class = require("Lib.30log")
ui = require("Lib.Loveframes")

MenuPanel = class("InventTab", {id, menu, dimensions})
function MenuPanel:init(id, menu, dimensions)
  
  self.id = id
  self.dimensions = dimensions
  self.slots = {}
  self.next_empty_slot = 1
  
  self.list = ui.Create("list")
    self.list:SetPos(0,0)
    self.list:SetSize(self.dimensions[3], self.dimensions[4])
    self.list:SetPadding(5)
    self.list:SetSpacing(5)
    self.list:EnableHorizontalStacking("true")
end