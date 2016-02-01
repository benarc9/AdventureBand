class = require("Lib.30log")

Debug = class("Debug", {})
function Debug:init()
  self.item_db = io.open("debug/db_item.txt", "w")
end


function Debug:item_report(items)
  for index, item in ipairs(items) do
    self.item_db:write("Name: "..item.id.."\n"..
                       " Pos: ("..item.pos.x..", "..item.pos.y..")\n")
    
    if item.test then
      self.item_db:write("Test: "..item.test.."\n")
    else
      self.item_db:write("Test: Not good...".."\n")
    end
                     
                     
    if item.slot then
      self.item_db:write("Slot: "..item.slot.."\n\n")
    else
      self.item_db:write("Slot: nil\n\n")
    end
    
    
      
  end
end