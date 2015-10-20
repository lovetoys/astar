Grid = class("Grid")

local PositionComponent, TileComponent = Component.load({"PositionComponent", "TileComponent"})

function Grid:initialize(x, y)
    self.grid = {}
    for i = x, 1, -1 do
        self.grid[i] = {}
        for j = y, 1, -1 do
            self.grid[i][j] = {child = {}}
        end
    end
    self.height = y
    self.width = x
end

function Grid:getHeight()
    return self.height
end

function Grid:getWidth()
    return self.width
end

function Grid:connect()
    for index, column in pairs(self.grid) do
        for index2, row in pairs(self.grid[index]) do
            if self.grid[index][index2-1] then
                self.grid[index][index2].child.top = self.grid[index][index2-1]
            end
            if self.grid[index][index2+1] then
                self.grid[index][index2].child.bottom = self.grid[index][index2+1]
            end
            if self.grid[index-1] then
                if self.grid[index-1][index2] then
                    self.grid[index][index2].child.left = self.grid[index-1][index2]
                end
            end
            if self.grid[index+1] then
                if self.grid[index+1][index2] then
                    self.grid[index][index2].child.right = self.grid[index+1][index2]
                end
            end
        end
    end
end

function Grid:connectHorizontal()
    for index, row in pairs(self.grid[1]) do
         self.grid[#self.grid][index].child.right = self.grid[1][index]
         self.grid[1][index].child.left = self.grid[#self.grid][index]
    end
end

function Grid:connectVertical()
    for index, column in pairs(self.grid) do
        self.grid[index][1].child.top = self.grid[index][#self.grid[index]]
        self.grid[index][#self.grid[index]].child.bottom = self.grid[index][1]
    end
end

function Grid:connectEverything()
    self:connect()
    self:connectHorizontal()
    self:connectVertical()
end

function Grid:populate()
    for i = self:getWidth(), 1, -1 do
        for j = self:getHeight(), 1, -1 do
            local entity = Entity()
            self.grid[i][j].index = i*self:getHeight() + j
            entity:add(PositionComponent((i-1)*40, (j-1)*40))
            entity:add(TileComponent(false))
            engine:addEntity(entity)
            self.grid[i][j].entity = entity
        end
    end
end

function Grid:erase()
    for i = self:getWidth(), 1, -1 do
        for j = self:getHeight(), 1, -1 do
            engine:removeEntity(self.grid[i][j].entity)
            self.grid[i][j].entity = nil
        end
    end
end


