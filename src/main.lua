-- Lib and Helper
require("lib/lovetoys/lovetoys")
require("helper/math")
require("helper/tables")
--Main Algorithm and Strucutres
require("algorithm/astar")
require("structures/grid")
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
require("events/keyReleased")
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
    eventManager:addListener("KeyReleased", {mainkey, mainkey.fireEvent})
    eventManager:addListener("MousePressed", {mainmouse, mainmouse.fireEvent})

    grid = Grid(32, 18)
    grid:connectEverything()

    engine:addSystem(TileDisplaySystem(), "draw", 1)
    engine:addSystem(PathDisplaySystem(), "draw", 2)
    engine:addSystem(mainkey, "logic", 1)
    grid:populate()
end

function love.update(dt)
    engine:update(dt)
end

function love.draw()
    engine:draw()
    love.graphics.setColor(0,0,0,255)
    love.graphics.print("Press 'Left mousebutton' to place the starting point", 10, 30)
    love.graphics.print("Press 'Right mousebutton' to place the endpoint", 10, 50)
    love.graphics.print("Press and hold 'Space' for placing or removing blocks", 10, 70)
    love.graphics.print("Press 'Enter' to calculate the route", 10, 90)
    love.graphics.print("Press 'Escape' to reset the simulation", 10, 110)
end 

function love.keypressed(key, isrepeat)
    eventManager:fireEvent(KeyPressed(key, isrepeat))
end

function love.keyreleased(key)
    eventManager:fireEvent(KeyReleased(key))
end

function love.mousepressed(x, y, button)
    eventManager:fireEvent(MousePressed(x, y, button))
end
