local Visual = {
    active = true,
    components = {},
    timer = 0,
    lifetime = 0,
}

function Visual:new(lifetime)
    self.__index = self
    return setmetatable({ lifetime = lifetime }, self)
end

function Visual:update(dt)
    for i, c in self.components do

    end
end

function Visual:addBehavior(c)
    table.insert(self.components, c)
end

return Visual
