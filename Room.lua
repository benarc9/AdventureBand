require("Lib.30log")

Room = class("Room", {map})
function Room:init(map)
  self.map = map
  
  self.pos = {}
    self.pos.x = nil
    self.pos.y = nil
  
  self.size = {}
    self.size.w = nil
    self.size.h = nil
  
  self.center = {}
    self.center.x = nil
    self.center.y = nil
  
end


function Room:set_pos(start_x)
  if start_x == 0 then
    self.pos.x = math.random(1, 3)
  else
    self.pos.x = math.random(start_x, start_x + 10)
  end
  
  self.pos.y = math.random(1, self.map.map_tiles.h - 10)
end

function Room:set_size()
  self.size.w = math.random(4, 10)
  self.size.h = math.random(4, 10)
end

function Room:set_center()
  self.center.x = self.pos.x + math.ceil(self.size.w / 2)
  self.center.y = self.pos.y + math.ceil(self.size.h / 2)
end

function Room:get_last()
  return self.pos.x + self.size.w
end

function Room:toString()
  local string  = "\nPos: ("..self.pos.x..", "..self.pos.y..")"
  string = string.."\nSize: ("..self.size.w..", "..self.size.h..")"
  string = string.."\nCenter: ("..self.center.x..", "..self.center.y..")\n\n"
  return string
end