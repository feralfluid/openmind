-- entity component system
local ecs = {}

-- world
local World = {}
World.__index = World

-- new world
function ecs.world()
    return setmetatable({
        entities = {},
        systems = {}
    }, World)
end

function World:spawn(e)
    local e = e or {}
    table.insert(self.entities, e)
    return e
end

function World:update(filter, ...)
    filter = filter or self.systems
    -- for each system
    for _, system in ipairs(filter) do
        -- for each entity in the world
        for _, entity in ipairs(self.entities) do
            -- call the system!
            system(entity, ...)
        end
    end
end

-- system
local System = {}
System.__index = System
System.__call = function(self, entity, ...)
    if self:match(entity) then
        self.fn(entity, ...)
    end
end

-- new system
function ecs.system(query, fn)
    return setmetatable({
        query = query,
        fn = fn
    }, System)
end

function System:match(entity)
    for _, componentName in ipairs(self.query) do
        if not entity[componentName] then
            return false
        end
    end
    return true
end

return ecs
