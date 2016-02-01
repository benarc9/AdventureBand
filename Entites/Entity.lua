class = require("Lib.30log")
require("Lib.Vector")

Entity = class("Entity", {type})
  function Entity:init(type)
    self.entity_type = type or "entity"
    
    self.point = {}
      self.point.x = nil
      self.point.y = nil
      
    self.pos = {}
      self.pos.x = nil
      self.pos.y = nil
      
    self.index = {}
      self.index.x = nil
      self.index.y = nil
  end
  
  function Entity:set_pos(i,j)
    self.pos.x = i * 16
    self.pos.y = j * 16
    self.point.x = i
    self.point.y = j
    self.index.x = i
    self.index.y = j
  end
  
  function Entity:get_pos()
    return self.pos
  end
  
  function Entity:get_index()
    return self.point
  end
  
  function Entity:__tostring()
    return "Entity, Type of: "..self.entity_type.." Tile Position: "..self.position.get()[0]..", "..self.position.get         ()[1]
  end