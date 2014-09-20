-- Lib and Helper
require("lib/lovetoys/src/engine")
require("helper/math")
require("helper/tables")
--Main Algorithm and Strucutres
require("algorithm/astar")
require("structures/matrix")
--Systems
require("systems/tileDisplaySystem")
require("systems/pathDisplaySystem")
require("systems/mainKeySystem")
require("systems/mainMousePressedSystem")
--Components
require("components/positionComponent")
require("components/tileComponent")
require("components/collidable")

--Events
require("events/keyPressed")
require("events/mousePressed")

function love.load()
    love.window.setMode(1280, 720, {fullscreen=false, resizable=false, vsync=true})

    beginning = nil
    ende = nil
    path = nil

    astar = AStar()
    engine = Engine()
    eventManager = EventManager()
    local mainmouse = MainMousePressedSystem()
    local mainkey = MainKeySystem()
    eventManager:addListener("KeyPressed", {mainkey, mainkey.fireEvent})
    eventManager:addListener("MousePressed", {mainmouse, mainmouse.fireEvent})

    matrix = Matrix(32, 18)
    matrix:connect()

    engine:addSystem(TileDisplaySystem(), "draw", 1)
    engine:addSystem(PathDisplaySystem(), "draw", 2)
    engine:addSystem(MainKeySystem(), "logic", 1)
    for i = matrix:getWidth(), 1, -1 do
        for j = matrix:getHeight(), 1, -1 do
            local entity = Entity()
            matrix.matrix[i][j].index = i*matrix:getHeight() + j
            entity:add(PositionComponent((i-1)*40, (j-1)*40))
            entity:add(TileComponent(false))
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
