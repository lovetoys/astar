MainMousePressedSystem = class("MainMousePressedSystem")

function MainMousePressedSystem:fireEvent(event)
    local x, y = event.x, event.y 
    local tile = getTile(matrix, x, y)
    if event.button == "r" then
        ende = tile
    elseif event.button == "l" then
        beginning = tile
    end
end