local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

-- Dependencies
local Binder = require(ReplicatedStorage.Common.Binder)
local Cleanup = require(ReplicatedStorage.Common.Cleanup)
local Loader = require(ReplicatedStorage.Common.Loader)

-- Binders
local components = Loader.LoadChildren(ServerScriptService.Server.Components)
local binders = {}

for componentName, component in components do
    binders[componentName] = Binder.new(componentName, component)
end

for _, binder in binders do
    binder:Start()
end

-- Load Services
local services = Loader.LoadChildren(ServerScriptService.Server.Services)
for _, service in services do
    if service.Start then
        service:Start()
    end
end