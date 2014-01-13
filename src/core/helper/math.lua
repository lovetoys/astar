-- Returns the distance between the two Positions.
-- A position is  specified as a table with two values: {x, y}.
function distanceBetween(pos1, pos2)
    relativeX = pos1[1] - pos2[1]
    relativeY = pos1[2] - pos2[2]
    return math.sqrt(relativeX*relativeX + relativeY*relativeY)
end

function distanceBetweenEntities(entity1, entity2)
    local pos1, pos2 = {}, {}
    pos1[1], pos1[2] = entity1:getComponent("PositionComponent").x, entity1:getComponent("PositionComponent").y
    pos2[1], pos2[2] = entity2:getComponent("PositionComponent").x, entity2:getComponent("PositionComponent").y
    return distanceBetween(pos1, pos2)
end

function insideRadius(entity1, entity2, radius)
    position1 = entity1:getComponent("PositionComponent")
    position2 = entity2:getComponent("PositionComponent")
    if distanceBetween({position1.x, position1.y}, {position2.x, position2.y}) <= radius
    or distanceBetween({position1.x - love.graphics.getWidth(), position1.y}, {position2.x, position2.y}) <= radius
    or distanceBetween({position1.x + love.graphics.getWidth(), position1.y}, {position2.x, position2.y}) <= radius then
        return true
    else
        return false
    end
end

function getMid(entity1, entity2)
    local x1, y1 = entity1:getComponent("PositionComponent").x, entity1:getComponent("PositionComponent").y
    local x2, y2 = entity2:getComponent("PositionComponent").x, entity2:getComponent("PositionComponent").y

    return (x1 + x2)/2 , (y1 + y2)/2 
end

function getSinCos(x, y, xt, yt)
    local akat, gkat
    akat = xt - x
    gkat = yt - y

    local hypo = math.sqrt(math.pow(gkat, 2) + math.pow(akat, 2))
    local sin = gkat/hypo
    local cos = akat/hypo
    return sin, cos
end

function getRadian(x, y, xt, yt)
    local akat, gkat
    akat = xt - x
    gkat = yt - y
    return math.atan2(akat, -gkat)-math.pi/2
end

function getAngle(x, y, xt, yt)
    return getRadian(x, y, xt, yt) * 180/math.pi
end

function getTile(matrix, x, y)
    local xtile = math.ceil(x/40)
    local ytile = math.ceil(y/40)
    return matrix.matrix[xtile][ytile]
end