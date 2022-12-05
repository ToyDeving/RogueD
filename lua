local UIS = game:GetService("UserInputService")
local PLR = game.Players.LocalPlayer

local IsEnabled = false
local Destroy = false
local DB = false

local Remote = game.ReplicatedStorage.Knit.Packages.Knit.Services.BreathingService.RE.Breath

local BeganConnection

BeganConnection = UIS.InputBegan:Connect(function(Input, BGE)
	if BGE and not DB then return end
	if Input.KeyCode == Enum.KeyCode.RightAlt then
		DB = true
		task.delay(0.5, function()
			DB = false
		end)
		if IsEnabled == false then
			IsEnabled = true
			Run(IsEnabled)
		else
			IsEnabled = false
		end
	elseif Input.KeyCode == Enum.KeyCode.U then
		Destroy = true
		BeganConnection:Disconnect()
	end
end)

function Run(Val)
	if Val == true then
		task.spawn(function()
			while IsEnabled and PLR.Character and PLR.Character.Parent ~= nil or Destroy do
				local BreathingCharge = PLR.Character:WaitForChild("BreathCharge")
				Remote:FireServer("Start")
				repeat task.wait() until  BreathingCharge.Value >= 100
				Remote:FireServer("Stop")
				repeat task.wait() until  BreathingCharge.Value <= 8.5
				task.wait(0.1)
			end
		end)
	end
end
