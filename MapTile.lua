class = require("Lib.30log")
require("Lib.Vector")

MapTile = class("MapTile", {})

function MapTile:init()
  self.type = nil
  
  self.walkable = false
  self.occupied = false
  
  self.occupier = nil
  
  self.position = {}
    self.position.x = 0
    self.position.y = 0
  
  self.point = {}
    self.point.x = nil
    self.point.y = nil
    
  self.index = {}
    self.index.x = nil
    self.index.y = nil
  
  self.image = {}
    self.image.base = nil
    self.image.overlay = nil
  
  
  self.lit = false
  self.discovered = false
  self.needs_check = false
  
  self.items = {}
  
end
  
  function MapTile:set_traversable(value)
    self.walkable = value
  end
  
  function MapTile:set_pos(x,y)
    self.position.x = x * 16
    self.position.y = y * 16
    self.point.x = x
    self.point.y = y
    self.index.x = x 
    self.index.y = y
  end
  
  function MapTile:get_pos()
    return self.position
  end
  
  function MapTile:get_index()
    return self.point
  end
  
  function MapTile:set_type(type)
    self.type = type
  end
  
  function MapTile:get_type()
    return self.type
  end
  
  function MapTile:get_occupier()
    if self.occupied then
      return self.occupier
    end
  end
  
  function MapTile:set_occupier(entity)
    self.occupied = true
    self.walkable = false
    self.occupier = entity
  end
  
  function MapTile:remove_entity()
    self.occupied = false
    self.occupier = nil
    if self.type == "ground" then
      self.walkable = true
    end
  end
  
  function MapTile:has_item()
    if self.items[1] then
      return true
    else
      return false
    end
  end
  
  
  function MapTile:equals(other_tile)
    if self.index.x == other_tile.index.x and self.index.y == other_tile.index.y then
      return true
    else
      return false
    end
  end