local CollectionService = game:GetService("CollectionService")
local Cleanup = require(script.Parent.Cleanup)

local Binder = {}
Binder.__index = Binder

function Binder.new(tag, class)
    local self = setmetatable({}, Binder)

    self.Objects = {}
    self.Tag = tag
    self.Class = class
    self.betterTrove = Cleanup.new()

    return self
end

function Binder:Bind(instance)
    self.Objects[instance] = self.Class.new(instance)
end

function Binder:Unbind(instance)
    self.Object[instance]:Destroy()
    self.Objects[instance] = nil
end

function Binder:Start()
    for _, instance in CollectionService:GetTagged(self.Tag) do
        self:Bind(instance)
    end

    self.betterTrove:Connect(CollectionService:GetInstanceAddedSignal(self.Tag), function(instance)
        self:Bind(instance)
    end)

    self.betterTrove:Connect(CollectionService:GetInstanceRemovedSignal(self.Tag), function(instance)
        self:Unbind(instance)
    end)
end

function Binder:Destroy()
    self.betterTrove:Clean()

    for _, instance in CollectionService:GetTagged(self.Tag) do
        self:Unbind(instance)
    end
end

return Binder