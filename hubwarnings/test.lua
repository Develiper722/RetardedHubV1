--// Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LobbyWarningUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

--// Create Frame on the left side
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 50) -- Width 300, Height 50
frame.Position = UDim2.new(0, 0, 0.4, 0) -- Left side, vertically centered-ish
frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Red background
frame.BorderSizePixel = 0
frame.Parent = screenGui

--// Create TextLabel
local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.BackgroundTransparency = 1
textLabel.Text = "This Script Doesn't work in this game or there was a error doing something idk"
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.TextScaled = true
textLabel.Font = Enum.Font.SourceSansBold
textLabel.Parent = frame
