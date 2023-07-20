local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Cleanup = require(ReplicatedStorage.Common.Cleanup)

local Lava = {}
Lava.__index = Lava

function Lava.new(platform)
    local self = setmetatable({}, Lava)
    self.betterTrove = Cleanup.new()

    self.betterTrove:Connect(platform.Touched, function(touchedPart)
        if not touchedPart.Parent then
            return
        end

        local humanoid = touchedPart.Parent:FindFirstChildOfClass("Humanoid")

        if humanoid then
            humanoid.Health = 0
        end
    end)
end

function Lava:Destroy()
    self.betterTrove:Clean()
end

return Lava