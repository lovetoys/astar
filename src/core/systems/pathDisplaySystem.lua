PathDisplaySystem = class("PathDisplaySystem", System)


function PathDisplaySystem:draw()
    if path then
        for index, tile in pairs(path) do
            local position = tile.entity:getComponent("PositionComponent")
            love.graphics.setColor(0, 0, 155, 155)
            love.graphics.rectangle("fill", position.x, position.y, 40, 40)
        end
    end
end

function PathDisplaySystem:getRequiredComponents()
    return {"Lotsastuff"}
end