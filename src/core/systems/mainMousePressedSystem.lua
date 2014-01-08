MainMousePressedSystem = class("MainMousePressedSystem")

function MainMousePressedSystem:fireEvent(event)
    local x, y = event.x, event.y 
    local tile = getTile(matrix, x, y)
    if event.button == "r" then
        goal = tile
    elseif event.button == "l" then
        start = tile
    end
end