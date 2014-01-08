-- Lib and Helper
require("core/lib/lua-lovetoys/lovetoys/engine")
require("core/helper/math")
require("core/helper/tables")
--Main Algorithm and Strucutres
require("core/algorithm/astar")
require("core/structures/matrix")
require("core/structures/vector")
--Systems
require("core/systems/tileDisplaySystem")
require("core/systems/pathDisplaySystem")
require("core/systems/mainKeySystem")
require("core/systems/mainMousePressedSystem")
--Components
require("core/components/positionComponent")
require("core/components/tileComponent")

--Events
require("core/events/keyPressed")
require("core/events/mousePressed")

function love.load()
    love.window.setMode(1280, 720, {fullscreen=false, resizable=false, vsync=true})

    start = nil
    goal = nil
    path = nil

    engine = Engine()
    eventManager = EventManager()
    local mainmouse = MainMousePressedSystem
    local mainkey = MainKeySystem
    eventManager:addListener("KeyPressed", {mainkey, mainkey.fireEvent})
    eventManager:addListener("MousePressed", {mainmouse, mainmouse.fireEvent})

    matrix = Matrix(32, 18)
    matrix:connect()

    engine:addSystem(TileDisplaySystem(), "draw", 1)
    engine:addSystem(PathDisplaySystem(), "draw", 2)
    engine:addSystem(MainKeySystem(), "logic", 1)

    for i = matrix:getWidth(), 0, -1 do
        for j = matrix:getHeight(), 0, -1 do
            local entity = Entity()
            entity:addComponent(PositionComponent(i*40, j*40))
            entity:addComponent(TileComponent(false, false))
            engine:addEntity(entity)
            matrix.matrix[i][j].entity = entity
        end
    end
end

function love.update(dt)
    engine:update(dt)
end

function love.draw()
    engine:draw()
end 

function love.keypressed(key, isrepeat)
    eventManager:fireEvent(KeyPressed(key, isrepeat))
end

function love.keyreleased(key, isrepeat)
end

function love.mousepressed(x, y, button)
    eventManager:fireEvent(MousePressed(x, y, button))
end
