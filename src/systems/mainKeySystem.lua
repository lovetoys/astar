MainKeySystem = class("MainKeySystem", System)

function MainKeySystem:__init()
    self.is_down = false
    self.is_block = false
end

function MainKeySystem.fireEvent(self, event)
    if event.__name == "KeyPressed" then
        if event.key == " " then
            local x, y = love.mouse.getPosition()
            local tile = getTile(grid, x, y)
            self.is_down = true
            if tile then
                if tile.entity:get("Collidable") then
                    self.is_block = true
                else
                    self.is_block = false
                end
            else
                self.is_block = false
            end
        elseif event.key == "escape" then
            for i = grid:getWidth(), 1, -1 do
                for j = grid:getHeight(), 1, -1 do
                    engine:removeEntity(grid.grid[i][j].entity)
                    local entity = Entity()
                    grid.grid[i][j].index = i*grid:getHeight() + j
                    entity:add(PositionComponent((i-1)*40, (j-1)*40))
                    entity:add(TileComponent(false))
                    engine:addEntity(entity)
                    grid.grid[i][j].entity = entity
                end
            end
            path = nil
        elseif event.key == "return" then
            for i = grid:getWidth(), 1, -1 do
                for j = grid:getHeight(), 1, -1 do
                    grid.grid[i][j].g = nil
                    grid.grid[i][j].parent = nil
                    grid.grid[i][j].f = nil
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
    else
        if event.key == " " then
            self.is_down = false
        end
    end
end


function MainKeySystem:update()
    if self.is_down then
        local x, y = love.mouse.getPosition()
        local tile = getTile(grid, x, y)
        if not self.is_block then
            if tile then
                tile.entity:add(Collidable())
            end
        else
            if tile then
                if tile.entity:has("Collidable") then
                    tile.entity:remove("Collidable")
                end
            end
        end
    end
end
