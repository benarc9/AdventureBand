class = require("Lib.30log")
require("Map")

Floor = class("Floor", {})
function Floor:init()
  self.rooms = {}
  
  self.room_limit = nil
  
  self.next_room_pos = {}
    self.next_room_pos.x = nil
    self.next_room_pos.y = nil
  
  self.next_room_size = {}
    self.next_room_size.w = nil
    self.next_room_size.h = nil
end