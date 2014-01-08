TileComponent = class("TileComponent")

function TileComponent:__init(active, collidable)
    self.active = active or false
    self.collidable = collidable or false
end

