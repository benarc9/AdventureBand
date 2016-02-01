class = require("Lib.30log")

Vector = class("Vector", {x,y})
  
  function Vector:init(x,y)
    self.tile_size = 16
    
    self.pix_pos = {}
    self.pix_pos[0] = 0
    self.pix_pos[1] = 0
    
    self.index = {}
    self.index[0] = 0
    self.index[1] = 0
  end
  
  function Vector:get()
    return self.pix_pos
  end
  
  function Vector:get_ind()
    return self.index
  end
  
  function Vector:set(x,y)
    self.index[0] = x
    self.index[1] = y
    self.pix_pos[0] = x * self.tile_size
    self.pix_pos[1] = y * self.tile_size
  end
  
  function Vector:__tostring()
    return "Vector Obj: ("..self.x..", "..self.y..")"
  end

  
  