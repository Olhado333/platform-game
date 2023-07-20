local Cleanup = {}
Cleanup.__index = Cleanup

function Cleanup.new()
    local self = setmetatable({}, Cleanup)
    self.objects = {}

    return self
end

function Cleanup:Add(object)
    self.objects[object] = true
    return object
end

function Cleanup:Remove(object)
    local t = typeof(object)

    if t == "Instance" then
        object:Destroy()
    elseif t == "RBXScriptConnection" then
        object:Disconnect()
    elseif t == "function" then
        object()
    elseif t == "table" then
        if object.Destroy then
            if typeof(object.Destroy) == "function" then
                object:Destroy()
            end
        elseif object.Disconnect then
            if typeof(object.Disconnect) == "function" then
                object:Disconnect()
            end
        end
    end

    self.objects[object] = nil
end

function Cleanup:Clone(object)
    return self:Add(object:Clone())
end

function Cleanup:Connect(signal, fn)
    return self:Add(signal:Connect(fn))
end

function Cleanup:Construct(class, ...)
    return self:Add(class.new(...))
end

function Cleanup:Clean()
    for object, _ in self.objects do
        self:Remove(object)
    end
end

return Cleanup