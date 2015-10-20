MainKeySystem = class("MainKeySystem", System)

local PositionComponent, TileComponent, Collidable = Component.load({"PositionComponent", "TileComponent", "Collidable"})

function MainKeySystem:initialize()
    System.initialize(self)
    self.isDown = false
    self.isBlock = false
end

function MainKeySystem:fireEvent(event)
    if event.class.name == "KeyPressed" then
        if event.key == "escape" then
            grid:erase()
            grid:populate()
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
    end
end


function MainKeySystem:update()
    if love.keyboard.isDown(" ") then
        -- Get current tile
        local x, y = love.mouse.getPosition()
        local tile = getTile(grid, x, y)

        -- Check if mouse is over a wall on initial keydown
        if self.isDown == false then
            if tile then
                if tile.entity:get("Collidable") then
                    self.isBlock = true
                else
                    self.isBlock = false
                end
                self.isDown = true
            else
                self.isBlock = false
                self.isDown = true
            end
        end
        if not self.isBlock then
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
    else
        self.isDown = false
    end
end
