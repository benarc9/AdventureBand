class = require("Lib.30log")
require("Lib.Loveframes")

Border = class("Border", {width, height})
function Border:init(width, height)
  self.frame = loveframes.Create("panel")
    self.frame:SetSize(width, height)
    self.frame:SetPos(971, 0)
  self.border = loveframes.Create("image", self.frame)
    self.border:SetImage("Images/UI/Border.png")
    self.border:SetScale(.05, 1.5)
end