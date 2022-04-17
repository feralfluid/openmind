local Ring = {
    x = 0,
    y = 0,
    z = 0,
    r = 0,
    t = 0,
    lifetime = 0
}

function Ring:new(o)
    self.__index = self
    return setmetatable(o or {}, self)
end

local rings = {}
local spawnInterval = 0.5
local cooldown = 0

function lovr.load()

end

function lovr.update(dt)
    if cooldown <= 0 then
        cooldown = cooldown + spawnInterval
        table.insert(rings, Ring:new({ z = 100, lifetime = 10 }))
    end

    for i, v in ipairs(rings) do
        -- increase life timer
        v.t = v.t + dt

        -- make em bigger for a bit
        if v.t < 1 then
            v.r = inOutSine(v.t, 0, 10, 1)
        else
            v.r = 10
        end

        -- move them all forward!
        v.z = v.z - 0.1

        -- despawn eventually.
        if v.z <= -100 then
            table.remove(rings, i)
        end
    end

    cooldown = cooldown - dt
end

function lovr.draw()
    for _, v in ipairs(rings) do
        lovr.graphics.setColor(1.0, 0.1, 0.5)

        -- fade in
        if v.t <= 1 then
            local r, g, b = lovr.graphics.getColor()
            lovr.graphics.setColor(r, g, b, v.t)
        end

        -- fade out
        if v.lifetime - v.t <= 1 then
            local r, g, b = lovr.graphics.getColor()
            lovr.graphics.setColor(r, g, b, v.lifetime - v.t)
        end

        lovr.graphics.circle("line", v.x, v.y, v.z, v.r)
    end
end

function inOutSine(t, b, c, d)
    return -c / 2 * (math.cos(math.pi * t / d) - 1) + b
end
