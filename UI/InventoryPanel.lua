class = require("Lib.30log")
ui = require("Lib.Loveframes")

InventPanel = class("InventTab", {ui, id, dimensions})
function InventPanel:init(ui, id, dimensions)
  
  self.id = id
  self.dimensions = dimensions
  self.slots = {}
  self.next_empty_slot = 1
  
  self.list = ui.Create("list")
    self.list:SetPos( 5, 40)
    self.list:SetSize(self.dimensions[3] - 10, self.dimensions[4] - 10)
    self.list:SetPadding(5)
    self.list:SetSpacing(5)
    self.list:EnableHorizontalStacking("true")
    
end




