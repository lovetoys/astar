Matrix = class("Matrix")

function Matrix:__init(x, y)
    self.matrix = {}
    for i = x, 1, -1 do
        self.matrix[i] = {}
        for j = y, 1, -1 do
            self.matrix[i][j] = {child = {}}
        end
    end
    self.height = y
    self.width = x
end

function Matrix:getHeight()
    return self.height
end

function Matrix:getWidth()
    return self.width
end

function Matrix:connect()
    for index, column in pairs(self.matrix) do
        for index2, row in pairs(self.matrix[index]) do
            if self.matrix[index][index2-1] then
                self.matrix[index][index2].child.top = self.matrix[index][index2-1]
            end
            if self.matrix[index][index2+1] then
                self.matrix[index][index2].child.bottom = self.matrix[index][index2+1]
            end
            if self.matrix[index-1] then
                if self.matrix[index-1][index2] then
                    self.matrix[index][index2].child.left = self.matrix[index-1][index2]
                end
            end
            if self.matrix[index+1] then
                if self.matrix[index+1][index2] then
                    self.matrix[index][index2].child.right = self.matrix[index+1][index2]
                end
            end
        end
    end
end

function Matrix:connectHorizontal()
    for index, row in pairs(self.matrix[1]) do
         self.matrix[#self.matrix][index].child.right = self.matrix[1][index]
         self.matrix[1][index].child.left = self.matrix[#self.matrix][index]
    end
end

function Matrix:connectVertical()
    for index, column in pairs(self.matrix) do
        self.matrix[index][1].child.top = self.matrix[index][#self.matrix[index]]
        self.matrix[index][#self.matrix[index]].child.bottom = self.matrix[index][1]
    end
end

function Matrix:connectEverything()
    self:connect()
    self:connectHorizontal()
    self:connectVertical()
end
    
