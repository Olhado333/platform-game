local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Cleanup = require(ReplicatedStorage.Common.Cleanup)

local TriggerService = {
    betterTroves = {},
}

function TriggerService:Bind(part, fn)
    local betterTrove = Cleanup.new()

    betterTrove:Connect(part.Touched, function(touchedPart)
        if touchedPart.Parent then
            local player = Players:GetPlayerFromCharacter(touchedPart.Parent)

            if player then
                fn(player)
            end

        end
    end)

    self.betterTroves[part] = betterTrove
end

function TriggerService:Unbind(part)
    self.betterTroves[part]:Clean()
end

return TriggerService