class = require("Lib.30log")

TileMap = class("TileMap",{tile_width, tile_height})
  function TileMap:init(tile_width, tile_height)
    self.tiles = {}
    for i = 0, tile_width do
      self.tiles[i] = {}
      for j = 0, tile_height do
        self.tiles[i][j] = 0
      end
    end
    
    self.lit_tiles = {}
    
    self.vert_count = tile_width
    self.horz_count = tile_height
    
    self.images = {}
    self.images.overlay = {}
    self.images.base = {}
    
    self.images.overlay.fog = love.graphics.newImage("Images/Tiles/fog_01.png")
    self.images.overlay.concealed = love.graphics.newImage("Images/Tiles/concealed_01.png")
    self.images.base.wall = love.graphics.newImage("Images/Tiles/tile_wall.png")
    self.images.base.ground = love.graphics.newImage("Images/Tiles/tile_ground.png")
    
  end
 
 
 function TileMap:add_item(x,y,item)
   table.insert(self.tiles[x][y].items, item)
 end
 
 function TileMap:get_item(x,y)
   if self.tiles[x][y]:has_item() then
      return self.tiles[x][y].items[1]
   else
      return nil
   end
 end
 
  ----Update
  function TileMap:update(map)
    
    for i = 0, map.map_tiles.w do
      for j = 0, map.map_tiles.h do
        if self.tiles[i][j].discovered then
          self.tiles[i][j].image.overlay = self.images.overlay.fog
        else
          self.tiles[i][j].image.overlay = self.images.overlay.concealed
        end
        
      end
    end
    
    if self.lit_tiles ~= nil then
      self:_set_all_lit()
    end
  end
  

  ----Visibility Tile List Manipulation
  function TileMap:add_lit_tile(tile)
    table.insert(self.lit_tiles, tile)
  end
  
  function TileMap:clear_lit_tiles()
    self.lit_tiles = {}
  end
  
  function TileMap:_set_all_lit()
    for i = 1, #self.lit_tiles do
      self.lit_tiles[i].image.overlay = nil
    end
  end

  
  function TileMap:_set_all_unlit()
    for i = 1, #self.lit_tiles do
      self.lit_tiles[i].lit = self.images.overlay.fog
    end
  end
  
  function TileMap:_set_tile_lit(tile)
    tile.lit = true
  end
  
  function TileMap:_set_tile_unlit(tile)
    tile.lit = false
  end
  

  ----Occupied Status
  function TileMap:is_occupied(x,y)
    if self.tiles[x][y].occupied then
      return true
    else
      return false
    end
  end
  
  
  
  ----Individual Tiles
  function TileMap:get_tile(x,y)
    if self.tiles[x][y] ~= nil then
      return self.tiles[x][y]
    end
  end
  
  function TileMap:add_tile(x,y,tile)
    self.tiles[x][y] = tile
  end
  
  function TileMap:get_rand_tile()
    local finished = false
    while finished == false do
      local x = math.random(1, self.horz_count)
      local y = math.random(1, self.vert_count)
      poss_tile = self.tiles[x][y]
      if poss_tile then
        if poss_tile.walkable == true then
          finished = true
          return poss_tile
        end
      end
    end
    return poss_tile
  end
  
  
  
  ----Entity
  function TileMap:add_entity(x,y,entity)
    if self.tiles[x][y].occupied == false then
      self.tiles[x][y]:set_occupier(entity)
    end
  end
  
  function TileMap:get_entity(x,y)
    if self.tiles[x][y].occupied then
      return self.tiles[x][y]:get_occupier()
    end
  end
  
  function TileMap:remove_ent(x,y)
    self.tiles[x][y]:remove_entity()
  end
  
  
  
  
  ----Type
  function TileMap:get_type(x,y)
    return self.tiles[x][y].type
  end 
  
  function TileMap:change_type(x,y,type)
    self.tiles[x][y]:set_type(type)
  end
  
  
  
  ----Traversing
  function TileMap:is_traversable(x,y)
    return self.tiles[x][y].walkable
  end
  
  function TileMap:set_traverse(x,y, is_traversable)
    self.tiles[x][y]:set_traversable(is_traversable)
  end
  
  
  
  ----Base Image
  function TileMap:set_base(x,y)
    if self.tiles[x][y].type == "ground" then
      self.tiles[x][y].image.base = self.images.base.ground
      self.tiles[x][y].walkable = true
    else
      self.tiles[x][y].image.base = self.images.base.wall
      self.tiles[x][y].walkable = false
    end
  end 
  
  function TileMap:get_base(x,y)
    return self.tiles[x][y].image.base
  end
  
  

  ----Overlay
  function TileMap:get_overlay(x,y)
    return self.tiles[x][y].image.overlay
  end
  
  
  ----Set Tile Visble
  function TileMap:set_visible(x,y)
    self.tiles[x][y].lit = true
  end
  
  function TileMap:set_discovered(x,y)
    self.tiles[x][y].discovered = true
  end
  
  function TileMap:set_invisible(x,y)
    self.tiles[x][y].lit = false
  end
  

      