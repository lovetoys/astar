MainKeySystem = class("MainKeySystem", System)

function MainKeySystem.fireEvent(self, event)
    -- Playercutie Jump
    if event.key == " " then
        local x, y = love.mouse.getPosition()
        local tile = getTile(matrix, x, y)
        tile.entity:getComponent("TileComponent").collidable = not tile.entity:getComponent("TileComponent").collidable
        tile.entity:addComponent(Collidable())
    elseif event.key == "escape" then
        for i = matrix:getWidth(), 0, -1 do
            for j = matrix:getHeight(), 0, -1 do
                local entity = Entity()
                entity:addComponent(PositionComponent(i*40, j*40))
                entity:addComponent(TileComponent(false, false))
                engine:addEntity(entity)
                engine:removeEntity(matrix.matrix[i][j].entity)
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