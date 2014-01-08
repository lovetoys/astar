KeyPressed = class("KeyPressed")

function KeyPressed:__init(key, isrepeat)
    self.key = key
    self.isrepeat = isrepeat
end