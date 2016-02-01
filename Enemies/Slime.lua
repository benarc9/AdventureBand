class = require("Lib.30log")
require("Enemy")

Slime = Enemy:extend("Slime", {})
  function Slime:init()
    name = "Slime"
    image_path = "Images/Enemy/img_Slime.png"
    
    lvl = 1
    exp = 0
    
    hp = 20
    mp = 0
    att = 5
    def = 0
    att_mod = 2
    
    speed = 1
    mv_speed = 1
    
    view_dist = 5
    
    melee_range = 1
    
    Slime.super.init(self, name, image_path, hp, mp, att, att_mod, def, speed, mv_speed, view_dist, melee_range)
  end
  
  