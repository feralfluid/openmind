local ecs = require "ecs"

-- world of entities
local visuals = ecs.world()

local spawnInterval = 1.0
local cooldown = 0

-- ring component
local ring = ecs.component("ring", {
    x = 0,
    y = 0,
    z = -100,
    radius = 10,
    r = 0.6,
    g = 0.1,
    b = 1.0,
})

-- an updatesystem for the ring
local updateRings = ecs.system({ "ring" }, function(e, dt)
    e.ring.z = e.ring.z + 0.1
end)

-- a drawsystem for the ring
local drawRings = ecs.system({ "ring" }, function(e)
    lovr.graphics.setColor(e.ring.r, e.ring.g, e.ring.b)
    lovr.graphics.circle("line", 0, 0, e.ring.z, 10)
end)

function lovr.update(dt)
    if cooldown <= 0 then
        cooldown = spawnInterval
        visuals:spawn({ ring })
    end

    -- updatesystems
    visuals:update({ updateRings }, dt)

    cooldown = cooldown - dt
end

function lovr.draw()
    -- drawsystems
    visuals:update({ drawRings })

    lovr.graphics.setColor(0xFFFFFF)
    lovr.graphics.print("hello world!", 0, 1, -1)
end

function inOutSine(t, b, c, d)
    return -c / 2 * (math.cos(math.pi * t / d) - 1) + b
end
