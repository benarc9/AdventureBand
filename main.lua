require("Player")
require("Room")
require("MapTile")
require("Enemy")
require("Enemies.Slime")
require("Lib.Vector")
require("Lib.30log")
require("TileMap")
require("Debug/debug")
require("UI.Gui")
require("MapLoader")
require("EnemySpawner")
require("ItemGenerator")

function love.load()
  --Seed the RNG with the system time
  loveframes = require("Lib.Loveframes")
  require("Lib.30log")
  math.randomseed(os.time())
  
  map = MapLoader:new(960, 640, 16, 16, 1)
  tileMap = TileMap:new(map.map_tiles.w, map.map_tiles.h)
  
--Window Setup
  love.window.setMode(map.map_pixels.w, map.map_pixels.h)
  
--Image Loading
  images = {}  
    images.ground = love.graphics.newImage("Images/Tiles/tile_ground.png")
    images.wall = love.graphics.newImage("Images/Tiles/tile_wall.png")
  
  images.fog_color = {255,255,255,200}

--Create Tilemap
  for i = 0, map.map_tiles.w do
    for j = 0, map.map_tiles.h do
      tileMap:add_tile(i,j,MapTile:new())
      tileMap:get_tile(i,j):set_pos(i,j)
      tileMap:get_tile(i,j):set_type("wall")
      tileMap:set_base(i,j)
      tileMap:set_traverse(i,j, false)
    end
  end
  
  
  tileMap:clear_lit_tiles()
  
  while map.map_full == false do
    map:create_room()
  end
  
  createMaze()
  dig_tunnel()
  
  gui = Gui:new(loveframes)
  gui:set_invent_panel("inventory")
  gui:set_equip_panel("equipment")
  
  
  spawn_player(gui)
  
  -- UI setup
  gui:set_status_panel("status", "Finn", player.base_hp)
  
  spawner = EnemySpawner:new(tileMap, 5)
  itemGen = ItemGenerator:new(5, tileMap)
  
  debug = Debug:new()
  debug:item_report(itemGen.items)
  
  gui:new_border(10, 50)
  
end
    
    
    
function love.mousepressed(x,y, button)
    loveframes.mousepressed(x,y, button)
  end

  function love.mousereleased(x,y,button)
    loveframes.mousepressed(x,y,button)
  end

  function love.keypressed(key, unicode)
    loveframes.keypressed(key, unicode)
  end

  function love.keyreleased(key, unicode)
    loveframes.keyreleased(key,unicode)
  end

  function love.textinput(text)
    loveframes.textinput(text)
  end


---Update the objects before display is updated
function love.update(dt)
  loveframes.update(dt)
  tile_update(map)
  player_update()
  tile_update(map)
  gui:update(player)
  
  
  if update == true then
    update = false
    enemy_update()
    npc_update()
  end
  mousePos = {}
  mousePos.x = love.mouse.getX()
  mousePos.y = love.mouse.getY()
end
  


---Draw Graphics to Screen
function love.draw() 
  
  --Draw Base Tile Images
  for i = 0, map.map_tiles.w do
    for j = 0, map.map_tiles.h do
      love.graphics.draw(tileMap:get_base(i,j), i * map.tile_size.w, j * map.tile_size.h)
    end
  end
  
  --Draw Enemy Sprites
  if spawner.count > 0 then
    local enemy_list = spawner.enemies
    for i = 1, #spawner.enemies do
      if enemy_list[i].visible then
        love.graphics.draw(enemy_list[i].image, enemy_list[i].pos.x, 
                                                enemy_list[i].pos.y)
      else
        love.graphics.setColor(images.fog_color)
        love.graphics.draw(enemy_list[i].image, enemy_list[i].last_seen_position.x, 
                                                enemy_list[i].last_seen_position.y)
        love.graphics.setColor(255,255,255,255)
      end
    end
  end
  
    --Draw Items
  for i = 1, #itemGen.items do
    local item = itemGen.items[i]
    if item.on_ground then
      love.graphics.draw(item.images.ground, item.pos.x * 16, item.pos.y * 16)
    end
  end
  
  --Draw Overlay
  for i = 0, map.map_tiles.w do
    for j = 0, map.map_tiles.h do
      if tileMap:get_tile(i,j).image.overlay == nil then
        --do nothing
      elseif tileMap:get_tile(i,j).image.overlay == tileMap.images.overlay.fog then
        love.graphics.setColor(images.fog_color)
        love.graphics.draw(tileMap:get_overlay(i,j), i * map.tile_size.w, j * map.tile_size.h)
        love.graphics.setColor(255,255,255,255)
      else
        love.graphics.draw(tileMap:get_overlay(i,j), i * map.tile_size.w, j * map.tile_size.h)
      end
    end
  end
  

  
  
  -- Resets the overlay tiles after they are drawn to the screen
  tileMap:clear_lit_tiles()
  
  --Draw Player Sprite
  love.graphics.draw(player.image, player.point.x * 16, player.point.y * 16)

  --Draw UI
  loveframes.draw()
  
end




--- UI Input Detection
function love.mousepressed(x,y, button)
  loveframes.mousepressed(x,y, button)
end

function love.mousereleased(x,y,button)
  loveframes.mousereleased(x,y,button)
end

function love.keypressed(key, unicode)
  loveframes.keypressed(key, unicode)
end

function love.keyreleased(key, unicode)
  loveframes.keyreleased(key,unicode)
end

function love.textinput(text)
  loveframes.textinput(text)
end




----Update Cycle
function tile_update()
  tileMap:update(map)
end

function player_update()
  player:update(tileMap, map.map_tiles.w, map.map_tiles.h)
end

function npc_update()
  
end

function enemy_update()
  spawner:update(player)
end



---Spawn Player in random room
function spawn_player(gui)
  local inventory = gui.panels.invent
  player = Player:new("Player", "Images/Player/player.png" )
  player:spawn(map.room_count, map.rooms, tileMap)
  player:gui_init(inventory)
end




---Generate Dungeon Rooms
function createMaze()
  for i = 1, #map.rooms do
    local x = map:get_roompos(i).x
    local y = map:get_roompos(i).y
    local w = map:get_roomsize(i).w
    local h = map:get_roomsize(i).h
    local center_x = map:get_roomcenter(i).x
    local center_y = map:get_roomcenter(i).y
    
    for i = x, x + w do
      for j = y, y + h do
        if tileMap:get_tile(i,j) then
          tileMap:get_tile(i,j):set_type("ground")
          tileMap:set_base(i,j)
          tileMap:set_traverse(i,j, true)
        end
      end
    end
  end
end
    



---Dig Tunnels
function dig_tunnel()
  local prev_room = {}
  local next_room = {}
  
  for i = 1, #map.rooms - 1 do
    prev_room.x = map.rooms[i].pos.x
    prev_room.y = map.rooms[i].pos.y
    next_room.x = map.rooms[i + 1].pos.x
    next_room.y = map.rooms[i + 1].pos.y
    
    for x = (prev_room.x), next_room.x do
      if tileMap:get_tile(x, prev_room.y) ~= nil then
        tileMap:get_tile(x,prev_room.y):set_type("ground")
        tileMap:set_base(x,prev_room.y)
        tileMap:set_traverse(x,prev_room.y, true)
      end
    end
    
    if prev_room.y > next_room.y then
      for y = next_room.y, (prev_room.y ) do
        if tileMap:get_tile(next_room.x, y) ~= nil then
          tileMap:get_tile(next_room.x,y):set_type("ground")
          tileMap:set_base(next_room.x,y)
          tileMap:set_traverse(next_room.x,y, true)
        end
      end
    else if prev_room.y < next_room.y then
      for y = prev_room.y, (next_room.y ) do
        tileMap:get_tile(next_room.x, y):set_type("ground")
        tileMap:set_base(next_room.x,y)
        tileMap:set_traverse(next_room.x,y, true)
      end
    end
  end
  end
end
  
  
