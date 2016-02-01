class = require("Lib.30log")

Status = class("Status", {ui, id, name, base_hp})
function Status:init(ui, id, name, base_hp)
  
  
  self.id = id
  
  self.player_name = name
  
  self.base_hp = base_hp
  self.curr_hp = self.base_hp

  self.name_font = love.graphics.newFont("Fonts/at.tff", 18)
  self.health_font = love.graphics.newFont("Fonts/idolwild.ttf", 12)
  
  self.panel = ui.Create("panel")
    self.panel:SetPos(975,0)
    self.panel.width = 0
    self.panel.height = 0
  
  self.bg = ui.Create("image", self.panel)
    self.bg:SetImage("Images/UI/bg_cloud.png")
    self.bg.visible = true
    self.bg:SetPos(0, 0)
  
  self.portrait = {}
    self.portrait.good = love.graphics.newImage("Images/UI/portrait_finn_01.png")
    self.portrait.okay = love.graphics.newImage("Images/UI/portrait_finn_02.png")
    self.portrait.bad = love.graphics.newImage("Images/UI/portrait_finn_03.png")
    self.portrait.worse = love.graphics.newImage("Images/UI/portrait_finn_04.png")
    self.portrait.horrible = love.graphics.newImage("Images/UI/portrait_finn_05.png")
    
    self.portrait.image = ui.Create("image")
      self.portrait.image:SetImage(self.portrait.good)
      self.portrait.image:SetPos(990, 10)
  
  self.text_display = {}
    self.text_display.base_hp = ui.Create("text", self.panel)
    self.text_display.base_hp:SetText(self.curr_hp.."/")
    self.text_display.base_hp:SetFont(self.health_font)
    self.text_display.base_hp:SetPos(80, 60)
    
    self.text_display.curr_hp = ui.Create("text", self.panel)
    self.text_display.curr_hp:SetText(self.base_hp)
    self.text_display.curr_hp:SetFont(self.health_font)
    self.text_display.curr_hp:SetPos(100, 60)
    
    self.text_display.name = ui.Create("text", self.panel)
    self.text_display.name:SetText(self.player_name)
    self.text_display.name:SetFont(self.name_font)
    self.text_display.name:SetPos(80, 40)
end


function Status:set_name(name)
  self.player_name = name
end

function Status:set_base_hp(hp)
  self.base_hp = hp
end

function Status:set_curr_hp(hp)
  self.curr_hp = hp
end

function Status:get_id()
  return self.id
end

function Status:update(player)
  self.curr_hp = player.curr_hp
  self.base_hp = player.base_hp
  
  self.text_display.base_hp:SetText(self.curr_hp.."/")
  self.text_display.curr_hp:SetText(self.base_hp)
  
  local perc = self.curr_hp / self.base_hp
  
  if perc > .8 then
    self.portrait.image:SetImage(self.portrait.good)
  elseif perc > .6 and perc <= .8 then
    self.portrait.image:SetImage(self.portrait.okay)
  elseif perc > .4 and perc <= .6 then
    self.portrait.image:SetImage(self.portrait.bad)
  elseif perc > .2 and perc <= .4 then
    self.portrait.image:SetImage(self.portrait.worse)
  else
    self.portrait.image:SetImage(self.portrait.horrible)
  end
end

