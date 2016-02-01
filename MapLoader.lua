class = require("Lib.30log")
room  = require("Room")


MapLoader = class("MapLoader", {pixel_width, pixel_height, 
                                tile_width, tile_height, items_to_place})
function MapLoader:init(pixel_width, pixel_height, tile_width, tile_height, items_to_place)
  
  self.map_pixels = {}
    self.map_pixels.w = pixel_width + 240
    self.map_pixels.h = pixel_height
  
  self.tile_size = {}
    self.tile_size.w = tile_width
    self.tile_size.h = tile_height
    
  self.map_tiles = {}
    self.map_tiles.w = (self.map_pixels.w - 240) / self.tile_size.w
    self.map_tiles.h = self.map_pixels.h / self.tile_size.h
    
  
  self.room_limits = {}
    self.room_limits.max = {}
      self.room_limits.max.w = 10
      self.room_limits.max.h = 10
    self.room_limits.min = {}
      self.room_limits.min.w = 4
      self.room_limits.min.h = 4
  
  
  self.current_flr_lvl = 1
  
  self.floor = nil
  
  self.room_limit = self.map_tiles.w
  
  self.rooms = {}
  
  self.current_room = nil
  self.room_count = 0
  self.map_full = false
  
  self.next_pos = 0
end

function MapLoader:create_room()

  self.current_room = Room:new(self)
  self.current_room:set_pos(self.next_pos)
  self.current_room:set_size()
  self.current_room:set_center()
                          
  if self.current_room:get_last() < self.map_tiles.w + 1 then
    table.insert(self.rooms, self.current_room)
    self.room_count = self.room_count + 1
    self.next_pos = self.current_room.center.x
  else
    self.map_full = true
  end
end

function MapLoader:get_room(index)
  return self.rooms[index]
end

function MapLoader:get_roompos(index)
  return self.rooms[index].pos
end

function MapLoader:get_roomsize(index)
  return self.rooms[index].size
end

function MapLoader:get_roomcenter(index)
  return self.rooms[index].center
end




