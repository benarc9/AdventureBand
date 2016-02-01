class = require("Lib.30log")
require("UI.Status")
require("UI.Equipment")
require("UI.Inventory")
require("UI.Border")
require("UI.Menu")

Gui = class("Gui", {lf})
function Gui:init(lf)
  self.panels = {}
    self.panels.status = nil
    self.panels.equip = nil
    self.panels.invent = nil
    self.panels.border = nil
    self.panels.char_menu = nil
    
  self.lf = lf
  
  
end

function Gui:set_status_panel(id, name, base_hp)
  self.panels.status = Status:new(self.lf, id, name, base_hp)
end

function Gui:set_equip_panel(id)
  self.panels.equip = Equipment:new(self.lf, id, self)
end

function Gui:set_invent_panel(id)
  self.panels.invent = Inventory:new(self.lf, id)
end

function Gui:set_charmenu_panel(id)
  self.panels.char_menu = Menu:new(self.lf)
end


function Gui:add_item_to_inventory(item)
    
end

function Gui:update(player)
  if self.panels.status ~= nil then
    self.panels.status:update(player)
  end
end

function Gui:new_border()
  self.panels.border = Border:new()
end


function Gui:get_panel(id)
  if id == "equipment" then
    return self.panels.equip
  elseif id == "inventory" then
    return self.panels.invent
  elseif id == "char_menu" then
    return self.panels.char_menu
  else
    return self.panels.status
  end
end