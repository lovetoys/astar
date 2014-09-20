MainKeySystem = class("MainKeySystem", System)

function MainKeySystem.fireEvent(self, event)
    if event.key == " " then
        local x, y = love.mouse.getPosition()
        local tile = getTile(matrix, x, y)
        if tile then
            tile.entity:get("TileComponent").collidable = not tile.entity:get("TileComponent").collidable
                if tile.entity:get("Collidable") then
                tile.entity:remove("Collidable")
            else
                tile.entity:add(Collidable())
            end
        end
    elseif event.key == "escape" then
        for index, entity in pairs(engine.entities) do
            engine:removeEntity(entity)
        end
        for i = matrix:getWidth(), 1, -1 do
            for j = matrix:getHeight(), 1, -1 do
                local entity = Entity()
                matrix.matrix[i][j] = {}
                matrix.matrix[i][j].index = i*matrix:getHeight() + j
                entity:add(PositionComponent((i-1)*40, (j-1)*40))
                entity:add(TileComponent(false))
                engine:addEntity(entity)
                matrix.matrix[i][j].entity = entity
            end
        end
        path = nil
    elseif event.key == "return" then
        for i = matrix:getWidth(), 1, -1 do
            for j = matrix:getHeight(), 1, -1 do
                matrix.matrix[i][j].g = nil
                matrix.matrix[i][j].parent = nil
                matrix.matrix[i][j].f = nil
            end
        end
        for index, entity in pairs(engine.entities) do
            if entity:get("TileComponent") then
                entity:get("TileComponent").active = false
            end
        end
        if beginning and ende then
            path = astar:find(beginning, ende)
        end
    end
end


function MainKeySystem:update()
    if love.keyboard.isDown("f") then
        local x, y = love.mouse.getPosition()
        local tile = getTile(matrix, x, y)
        if tile then
            tile.entity:add(Collidable())
        end
    end
end
