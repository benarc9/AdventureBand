class = require("Lib.30log")
require("UI.MenuPanel")

Menu = class("Char", {ui, stats, spells})
function Menu:init(ui, stats, spells)
  self.ui = ui
  
  self.stats = stats
  self.spells = spells
  
  self.char_menu = self.ui.Create("tabs")
    self.char_menu:SetPos(970, 0)
    self.char_menu:SetSize(230, 955)
  
  self.infotab = {}
    self.infotab.icon = {}
      self.infotab.icon.tab = self.ui.Create("panel")
        self.infotab.icon.tab.Draw = function () end
      self.infotab.icon.text = self.ui.Create("text", self.infotab.icon.tab)
        self.infotab.icon.text:SetText("Character")
      self.infotab.tab = MenuPanel:new("Info", menu, {self.char_menu:GetX(),
                                                      self.char_menu:GetY(),
                                                      self.char_menu:GetWidth(),
                                                      self.char_menu:GetHeight()
                                                      })
      
        
  self.spelltab = {}
    self.spelltab.icon = {}
      self.spelltab.icon.tab = self.ui.Create("panel")
        self.spelltab.icon.Draw = function () end
      self.spelltab.icon.text = self.ui.Create("text", self.spelltab.icon.tab)
        self.spelltab.icon.text:SetText("Magic")
      self.spelltab.tab = MenuPanel:new("Magic", menu, {self.char_menu:GetX(),
                                                        self.char_menu:GetY(),
                                                        self.char_menu:GetWidth(),
                                                        self.char_menu:GetHeight()
                                                        })
        
  self.tabs = {}
    self.tabs.main = self.char_menu:AddTab("Character", self.infotab.tab.list)
    self.tabs.magic = self.char_menu:AddTab("Magic", self.spelltab.tab.list)
        
  
end