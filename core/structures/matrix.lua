Matrix = class("Matrix")

function Matrix:__init(x, y)
    self.matrix
    for i = x, 0, -1 do
        self.matrix[i] = {}
        for j = y, 0, -1 do
            self.matrix[i][j] = {}
        end
    end
    self.height = x
    self.width = y
end

function Matrix:getHeight()
    return self.height
end

function Matrix:getWidth()
    return self.width
end

function Matrix:connect()
    for index, row in pairs(self.matrix) do
        for index2, column in pairs(self.matrix[row]) do
            if self.matrix[row][column-1] then
                self.matrix[row][column].top = self.matrix[row][column-1]
            end
            if self.matrix[row][column+1] then
                self.matrix[row][column].bottom = self.matrix[row][column+1]
            end
            if self.matrix[row-1] then
                if self.matrix[row-1][column] then
                    self.matrix[row][column].left = self.matrix[row-1][column]
                end
            end
            if self.matrix[row+1] then
                if self.matrix[row+1][column] then
                    self.matrix[row][column].right = self.matrix[row+1][column]
                end
            end
        end
    end
end

function Matrix:connectSites()
    for index, row in pairs(self.matrix) do
        for index2, column in pairs(self.matrix[row]) do
            if self.matrix[row][column-1] then
                self.matrix[row][column].top = self.matrix[row][column-1]
            end
            if self.matrix[row][column+1] then
                self.matrix[row][column].bottom = self.matrix[row][column+1]
            end
            if self.matrix[row-1] then
                if self.matrix[row-1][column] then
                    self.matrix[row][column].left = self.matrix[row-1][column]
                end
            else self.matrix[#self.matrix][column] then
                 self.matrix[row][column].left = self.matrix[#self.matrix][column]
            end
            if self.matrix[row+1] then
                if self.matrix[row-1][column] then
                    self.matrix[row][column].right = self.matrix[row+1][column]
                end
            else self.matrix[1][column] then
                 self.matrix[row][column].right = self.matrix[1][column]
            end
        end
    end
end
end