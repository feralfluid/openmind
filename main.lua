local ecs = require "ecs"

-- world of entities
local visuals = ecs.World:new()

local spawnInterval = 1.0
local cooldown = 0

-- let's define a SINGLE ring component that has everything we need.
local ring = ecs.Component:new("ring", {
    color = { r = 1.0, g = 0.1, b = 0.5 },
    z = -100,
})

-- an updatesystem for the ring
local updateRings = ecs.System:new({ "ring" }, function(e, dt)
    e.ring.data.z = e.ring.data.z + 0.1
end)

-- a drawsystem for the ring
local drawRings = ecs.System:new({ "ring" }, function(e)
    lovr.graphics.setColor(e.ring.data.color.r, e.ring.data.color.g, e.ring.data.color.b)
    lovr.graphics.circle("line", 0, 0, e.ring.data.z, 10)
end)

function lovr.update(dt)
    if cooldown >= spawnInterval then
        cooldown = 0
        visuals:spawn():add(ring:new())
    end

    -- updatesystems
    visuals:update({ updateRings }, dt)

    cooldown = cooldown + dt
end

function lovr.draw()
    -- hi :3
    lovr.graphics.setColor(1.0, 1.0, 1.0)
    lovr.graphics.print("hello world!", 0, 1, -1)

    -- drawsystems
    visuals:update({ drawRings })
end

function inOutSine(t, b, c, d)
    return -c / 2 * (math.cos(math.pi * t / d) - 1) + b
end
