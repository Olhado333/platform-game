local RunService = game:GetService("RunService")

local function Timer(duration, fn)
    local seconondsPassed = 0

    local connection = RunService.Heartbeat:Connect(function(deltaTime)
        seconondsPassed = seconondsPassed + deltaTime

        if seconondsPassed >= duration then
            fn()
            seconondsPassed = seconondsPassed - duration
        end
    end)

    return function()
        connection:Disconnect()
    end
end

return Timer