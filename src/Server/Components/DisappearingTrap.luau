local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Cleanup = require(ReplicatedStorage.Common.Cleanup)

local DisappearingTrap = {}
DisappearingTrap.__index = DisappearingTrap

-- DisappearingTrap.TAG = "DisappearTrap"
DisappearingTrap.FADE_TIME = 2
DisappearingTrap.DURATION = 5
DisappearingTrap.RISE_TIME = 2

function DisappearingTrap.new(platform)
    local self = setmetatable({}, DisappearingTrap)
    self.platform = platform
    self.isDisappearing = false
    self.betterTrove = Cleanup.new()

    self.betterTrove:Connect(platform.Touched, function()
        self:OnTouch()
    end)

    return self
end

function DisappearingTrap:OnTouch()
    if self.isDisappearing then
        return
    end

    local tween = self:Disappear()

    tween.Completed:Connect(function()
        self:Reappear()
    end)
end

function DisappearingTrap:Disappear()
    local goal = {
        Transparency = 1,
    }
    local tweenInfo = TweenInfo.new(self.FADE_TIME, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(self.platform, tweenInfo, goal)
    self.isDisappearing = true
    tween:Play()

    return tween
end

function DisappearingTrap:Reappear()
    local positionGoal = {
        Position = self.platform.Position,
    }

    local colorGoal = {
        Color = self.platform.Color,
    }

    self.platform.CanCollide = false
    self.platform.Position = self.platform.Position - Vector3.new(0, 45, 0)
    self.platform.Color = Color3.new(0.219607, 0.105882, 0)

    task.delay(self.DURATION, function()
        self.platform.Transparency = 0
        self.platform.CanCollide = true

        local positionTweenInfo = TweenInfo.new(self.RISE_TIME, Enum.EasingStyle.Exponential)
        local colorTweenInfo = TweenInfo.new(self.RISE_TIME, Enum.EasingStyle.Exponential, Enum.EasingDirection.In)
        local positionTween = TweenService:Create(self.platform, positionTweenInfo, positionGoal)
        local colorTween = TweenService:Create(self.platform, colorTweenInfo, colorGoal)
        positionTween:Play()
        colorTween:Play()

        positionTween.Completed:Connect(function()
            self.isDisappearing = false
        end)
    end)
end

function DisappearingTrap:Destroy()
    self.betterTrove:Clean()
end

return DisappearingTrap
