local Players = game:GetService("Players")

local PointService = {}

function PointService:Start()

    for _, player in Players:GetPlayers() do
        self:OnPlayerAdded(player)
    end

    Players.PlayerAdded:Connect(function(player)
        self:OnPlayerAdded(player)
    end)
end

function PointService:OnPlayerAdded(player)
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local points = Instance.new("IntValue")
    points.Name = "points"
    points.Parent = leaderstats
end

function PointService:Update(player, fn)
    local pointsValue = self:GetPointsValue(player)

    if pointsValue then
        pointsValue.Value = fn(pointsValue.Value)
    end
end

function PointService:GetPointsValue(player)
    if not player:FindFirstChild("leaderstats") then
        return nil
    end

    if not player.leaderstats:FindFirstChild("points") then
        return nil
    end

    return player.leaderstats.points
end

return PointService