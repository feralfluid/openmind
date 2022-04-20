local ecs = require "ecs"

-- world of entities
local visuals = ecs.world()

local spawnInterval = 1.0
local cooldown = 0

-- an updatesystem for the ring
local updateRings = ecs.system({ "location", "radius", "color" }, function(e, dt)
    e.location.z = e.location.z + 0.1
end)

-- a drawsystem for the ring
local drawRings = ecs.system({ "location", "radius", "color" }, function(e)
    lovr.graphics.setColor(e.color.r, e.color.g, e.color.b)
    lovr.graphics.circle("line", 0, 0, e.location.z, 10)
end)

function lovr.update(dt)
    if cooldown <= 0 then
        cooldown = spawnInterval
        visuals:spawn({
            -- location component
            location = {
                x = 0,
                y = 0,
                z = -100
            },
            -- radius component
            radius = 10,
            -- color component
            color = {
                r = 0.6,
                g = 0.1,
                b = 1.0
            }
        })
    end

    -- updatesystems
    visuals:update({ updateRings }, dt)

    cooldown = cooldown - dt
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
