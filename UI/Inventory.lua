class = require("Lib.30log")
require("UI.InventoryPanel")

Inventory = class("Inventory", {ui, id, gui})
function Inventory:init(ui, id, gui)
  self.id = id
  self.gui = gui
    
  self.tabs = ui.Create("tabs")
    self.tabs:SetPos(200,180)
    self.tabs:SetSize(600,350)
    self.tabs.visible = false
    
  self.weapon_tab = {}
    self.weapon_tab.image = love.graphics.newImage("Images/UI/invent_icon_weapon.png")
    self.weapon_tab.icon_panel = ui.Create("panel")
      self.weapon_tab.icon_panel.Draw = function() end
      self.weapon_tab.icon_panel:SetSize(128,128)
      self.weapon_tab.icon_panel:SetPos(0,0)
      self.weapon_tab.tab = InventPanel:new(
            ui,
            "weapon_invent", 
            {
              self.tabs:GetX(), self.tabs:GetY(),  
              self.tabs:GetWidth(), self.tabs:GetHeight()
            },
            self.tabs
        )
  
  self.armor_tab = {}
    self.armor_tab.image = love.graphics.newImage("Images/UI/invent_icon_armor.png")
    self.armor_tab.icon_panel = ui.Create("panel")
      self.armor_tab.icon_panel.Draw = function () end
      self.armor_tab.icon_panel:SetSize(128 ,128)
      self.armor_tab.icon_panel:SetPos(0,0)
      self.armor_tab.tab = InventPanel:new(
            ui,
            "armor_invent",
            {
              self.tabs:GetX(), self.tabs:GetY(),
              self.tabs:GetWidth(), self.tabs:GetHeight()
            },
            self.tabs
         )
      
  self.close_button = {}
    self.close_button.image = {}
      self.close_button.image.pressed = love.graphics.newImage(
        "Images/UI/invent_icon_close_pressed.png")
      self.close_button.image.notpressed = love.graphics.newImage(
        "Images/UI/invent_icon_close_notpressed.png")
    self.close_button.button = ui.Create("imagebutton", self.tabs)
      self.close_button.button:SetText("")
      self.close_button.button:SetImage(self.close_button.image.notpressed)
      self.close_button.button:SetPos(self.tabs:GetX() + self.tabs:GetWidth(), 
                                      self.tabs:GetY())
      self.close_button.button:SizeToImage()
      self.close_button.button.alwaysupdate = true
      self.close_button.button.OnClick = function (button)
        self:close_inventory()
      end
      self.close_button.button.Update = function()
        self.close_button.button.visible = self.tabs.visible
      end
      
      
    
  
  self.invent_tabs = {}
    self.invent_tabs.weapons = self.tabs:AddTab("", 
                                                self.weapon_tab.tab.list, 
                                                nil, 
                                                self.weapon_tab.image
                                               )
    self.invent_tabs.armor   = self.tabs:AddTab("", 
                                                self.armor_tab.tab.list,
                                                nil, 
                                                self.armor_tab.image
                                               )

end

function Inventory:open()
  self.tabs.visible = true
  self.close_button.button.visible = true
end

function Inventory:close_inventory()
  if self.tabs.visible then
    self.tabs.visible = false
  end
end

function Inventory:open_tab(tab)
  self.tabs.visible = true
  if tab == "weapons" then
    self.tabs:SwitchToTab(self.invent_tabs.weapons:GetTabNumber())
  elseif tab == "armor" then
    self.tabs:SwitchToTab(self.invent_tabs.armor:GetTabNumber())
  end
end

function Inventory:add_item(player, item)
  if item.type == "armor" then
    local button = ui.Create("imagebutton")
    button:SetImage(item.images.invent)
    button:SetSize(64,64)
    button:SetText("")
    button.OnClick = function ()
      gui.panels.equip:equip_item(item)
    end
    self.armor_tab.tab.list:AddItem(button)
  elseif item.type == "weapon" then
    local button = ui.Create("imagebutton")
    button:SetImage(item.images.invent)
    button:SetSize(64,64)
    button:SetText("")
    button.OnClick = function ()
      gui.panels.equip:equip_item(item)
    end
    self.weapon_tab.tab.list:AddItem(button)
  end
end

function Inventory:get_id()
  return self.id
end

