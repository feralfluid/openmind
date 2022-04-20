local Interval = {
    timer = 0,
    length = 0,
    callback = nil
}

function Interval:new(length, callback)
    self.__index = self
    return setmetatable({ length = length, callback = callback }, self)
end

function Interval:update(dt)
    self.timer = self.timer + dt
end

function Interval:reset()
    self.timer = 0
end

return Interval
