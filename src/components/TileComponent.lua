local TileComponent = Component.create("TileComponent")

function TileComponent:initialize(active)
    self.active = active or false
end

return TileComponent
