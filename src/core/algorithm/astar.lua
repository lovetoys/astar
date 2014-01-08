AStar = class("AStar")

function AStar:__init()
    self.openlist = {}
    self.closedlist = {}
end

function AStar:find(matrix, start, goal)
    table.insert(self.openlist, start)
    start.g = 0
    start.f = start.g + heuristicCost(start, goal)

    while #self.openlist ~= 0 do
        local active = self:getLowestF()

        for index, child in pairs(active.child) do
            if not child.entity:getComponent("Collidable") then
                local reactivated = false
                local notcontained = false
                if table.contains(self.closedlist, child) then
                    if child.g < active.g + distanceBetweenEntities(child.entity, active.entity) then
                        table.removeElement(self.closedlist, child)
                        reactivated = true
                    end
                else
                    notcontained = true
                end
                if notcontained or reactivated then
                    child.g = active.g + distanceBetweenEntities(child.entity, active.entity)
                    child.f = child.g + distanceBetweenEntities(child.entity, goal.entity)
                    child.parent = active

                    if child == goal then
                        return self.getPath(child, {})
                    else
                        if not table.contains(self.openlist, child) then
                            table.insert(self.openlist, child)
                        end
                    end
                end
            end
        end
    end
end

function AStar:heuristicCost(start, goal)
    return distanceBetweenEntities(start.entity ,goal.entity)
end

function AStar:getLowestF()
    local lowest = table.firstElement(self.openlist)
    for index, value in pairs(self.openlist) do
        if value.f < lowest.f then
            lowest = value
        end
    end
    return lowest
end

function AStar:getPath(element, path)
    table.insert(path, element)
    self:getPath(element.parent, path)
    local correctPath
    for i = #path, 1, -1 do
        table.insert(correctPath, path[i])
    end
    return correctPath 
end