TileDisplaySystem = class("TileDisplaySystem", System)

function TileDisplaySystem:__init()

end

function TileDisplaySystem:draw()
    for index, entity in pairs(self.targets) do
        local position = entity:getComponent("PositionComponent")
        if entity:getComponent("Collidable") then
            love.graphics.setColor(155, 155, 155, 155)
        elseif entity:getComponent("TileComponent").active == true then
            love.graphics.setColor(27, 195, 248, 155)
        else
            love.graphics.setColor(255, 255, 255, 255)
        end
        if ende then
            if entity == ende.entity then
                love.graphics.setColor(255, 0, 0, 255)
            end
        end
        if beginning then
            if entity == beginning.entity then
                love.graphics.setColor(0, 255, 0, 255)
            end
        end
        love.graphics.rectangle("fill", position.x, position.y, 40, 40)
    end
end

function TileDisplaySystem:getRequiredComponents()
    return {"PositionComponent", "TileComponent"}
end