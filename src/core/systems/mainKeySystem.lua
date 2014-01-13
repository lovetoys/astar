MainKeySystem = class("MainKeySystem", System)

function MainKeySystem.fireEvent(self, event)
    -- Playercutie Jump
    if event.key == " " then
        local x, y = love.mouse.getPosition()
        local tile = getTile(matrix, x, y)
        tile.entity:getComponent("TileComponent").collidable = not tile.entity:getComponent("TileComponent").collidable
        if tile.entity:getComponent("Collidable") then
            tile.entity:removeComponent("Collidable")
        else
            tile.entity:addComponent(Collidable())
        end
    elseif event.key == "escape" then
        for index, entity in pairs(engine.entities) do
            engine:removeEntity(entity)
        end
        for i = matrix:getWidth(), 1, -1 do
            for j = matrix:getHeight(), 1, -1 do
                local entity = Entity()
                matrix.matrix[i][j].index = i*matrix:getHeight() + j
                entity:addComponent(PositionComponent((i-1)*40, (j-1)*40))
                entity:addComponent(TileComponent(false, false))
                engine:addEntity(entity)
                matrix.matrix[i][j].entity = entity
            end
        end
        path = nil
    elseif event.key == "return" then
        if beginning and ende then
            path = astar:find(beginning, ende)
        end
    end
end


function MainKeySystem:update()
    if love.keyboard.isDown("f") then
        local x, y = love.mouse.getPosition()
        local tile = getTile(matrix, x, y)
        tile.entity:getComponent("TileComponent").collidable = true
        tile.entity:addComponent(Collidable())
    end
end