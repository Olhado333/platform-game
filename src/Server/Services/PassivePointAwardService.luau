local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Workspace = game.FindFirstChild(game, "Workspace")

local Timer = require(ReplicatedStorage.Common.Timer)
local PointService = require(ServerScriptService.Server.Services.PointService)
local TriggerService = require(ServerScriptService.Server.Services.TriggerService)
local PlayerDeathService = require(ServerScriptService.Server.Services.PlayerDeathService)

local PassivePointAwardService = {
    activePlayers = {}
}

function PassivePointAwardService:Start()

    TriggerService:Bind(workspace.PointTrigger, function(player)
        self.activePlayers[player] = true 
    end)

    PlayerDeathService:Bind(function(player)
        self.activePlayers[player] = nil
    end)

    PlayerDeathService:Bind(function(player)
        PointService:Update(player, function()
            return 0
        end)
    end)

    Timer(1, function()
        for player, _ in self.activePlayers do
            PointService:Update(player, function(points)
                return points + 1
            end)
        end
    end)
end

return PassivePointAwardService