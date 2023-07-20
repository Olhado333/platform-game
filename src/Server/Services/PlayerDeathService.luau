local Players = game:GetService('Players')
local ServerScriptService = game:GetService('ServerScriptService')

local PlayerDeathService = {
    callbacks = {},
}

function PlayerDeathService:Start()
    Players.PlayerAdded:Connect(function(player)
        self:PlayerAdded(player)
    end)
end

function PlayerDeathService:PlayerAdded(player)
    print("Player added")

    player.CharacterAdded:Connect(function(character)
        self:CharacterAdded(player, character)
    end)
end

function PlayerDeathService:CharacterAdded(player, character)
    print("Character added")

    character.Humanoid.Died:Connect(function()
        self:HumanoidDied(player)
    end)
end

function PlayerDeathService:HumanoidDied(player)
    for callback, _ in self.callbacks do
        callback(player)
    end
end

function PlayerDeathService:Bind(fn)
    self.callbacks[fn] = true
end

return PlayerDeathService