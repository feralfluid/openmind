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

function World:spawn(components)
    local entity = ecs.entity()
    for _, component in ipairs(components) do
        entity[component.__name] = component:new()
    end
    table.insert(self.entities, entity)
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

-- entity
local Entity = {}
Entity.__index = Entity

-- new entity
function ecs.entity()
    return setmetatable({}, Entity)
end

function Entity:with(components)

end

-- component
local Component = {}
Component.__index = Component

-- new component
function ecs.component(name, data)
    local component = data or {}
    component.__name = name
    return setmetatable(component, Component)
end

function Component:new()
    return setmetatable({}, { __index = self })
end

-- system
local System = {}
System.__index = System
System.__call = function(self, entity, ...)
    for _, componentName in ipairs(self.query) do
        if not entity[componentName] then
            return
        end
    end

    self.fn(entity, ...)
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
