-- entity component system
local ecs = {}

-- world prototype
ecs.World = {
    -- essentially tables of components
    entities = {},
    -- functions that do stuff with component data
    systems = {},
}

-- new world
function ecs.World:new()
    return setmetatable({}, ecs.World)
end

-- insert entity
function ecs.World:spawn(e)
    e = e or ecs.Entity:new()
    table.insert(self.entities, e)
    return e
end

-- insert system
function ecs.World:addSystem(system)
    table.insert(self.systems, system)
end

-- update world... execute systems?
function ecs.World:update(filter, ...)
    filter = filter or self.systems
    -- for each system
    for _, system in ipairs(filter) do
        -- assert that it is, in fact, a system
        assert(getmetatable(system) == ecs.System, "not a system!")
        -- for each entity in the world
        for _, entity in ipairs(self.entities) do
            -- __call() the system!
            system:call(entity, ...)
        end
    end
end

-- entity prototype
ecs.Entity = {}

function ecs.Entity:new()
    self.__index = self
    return setmetatable({}, self)
end

function ecs.Entity:add(component)
    assert(getmetatable(component) == ecs.Component, "not a component!")
    self[component.name] = component:new()
end

function ecs.Entity:remove(componentName)
    self[componentName] = nil
end

-- component class
ecs.Component = {
    name = nil,
    data = {},
}

function ecs.Component:new(name, data)
    self.__index = self
    return setmetatable({ name = name or self.name, data = data or {} }, self)
end

-- system prototype
ecs.System = {
    query = {},
    fn = nil,

    __call = function(self, entity, ...)
        if self:match(entity) then
            self.fn(entity, ...)
        end
    end,
}

function ecs.System:new(query, fn)
    self.__index = self
    return setmetatable({ query = query, fn = fn }, self)
end

function ecs.System:match(entity)
    for _, componentName in ipairs(self.query) do
        if not entity[componentName] then
            return false
        end
    end
    return true
end

-- TODO: remove
function ecs.System:call(entity, ...)
    if self:match(entity) then
        self["fn"](entity, ...)
    end
end

return ecs
