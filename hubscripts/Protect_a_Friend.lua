--// Rayfield UI by @system96 on Discord

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
	Name = "Breakables & Utilities | by @system96",
	LoadingTitle = "Loading System96 UI",
	LoadingSubtitle = "Breakables, Campfire, Bridge, Potion,"
	ConfigurationSaving = { Enabled = false },
})

local Tab = Window:CreateTab("Main", 4483362458)

local runService = game:GetService("RunService")
local rs = game:GetService("ReplicatedStorage")
local remotes = rs:WaitForChild("Remotes")

--// Variables
local currentBreakables = {}
local autoBreak = false
local autoCampfire = false
local autoBridge = false
local autoPotion = false
local autoShaman = false

--// Fetch Breakables
local function fetchBreakables()
	local breakables = workspace:WaitForChild("Breakables")
	currentBreakables = {}
	for _, folder in ipairs(breakables:GetChildren()) do
		if folder:IsA("Folder") then
			table.insert(currentBreakables, folder)
		end
	end
	Rayfield:Notify({
		Title = "Refetched Breakables",
		Content = "Found " .. tostring(#currentBreakables) .. " breakables.",
		Duration = 3,
		Image = 4483362458
	})
end

--// Fire Tool
local function fireTool(toolName)
	if #currentBreakables == 0 then return end
	remotes.Tool:FireServer(currentBreakables, 10, toolName)
end

--// Contributions
local function contribute(remoteName, resource, amount)
	local remote = remotes:WaitForChild(remoteName)
	remote:FireServer(resource, amount)
end

--// UsePotion & Shaman
local function callRemote(remoteName, resource)
	local remote = remotes:WaitForChild(remoteName)
	remote:FireServer(resource)
end

--// Buttons
Tab:CreateButton({
	Name = "Refetch Breakables",
	Callback = fetchBreakables
})

Tab:CreateButton({
	Name = "Break Wood (Golden Axe)",
	Callback = function() fireTool("Golden Axe") end
})

Tab:CreateButton({
	Name = "Break Stone (Golden Pickaxe)",
	Callback = function() fireTool("Golden Pickaxe") end
})

Tab:CreateButton({
	Name = "Contribute 100 Logs to Campfire",
	Callback = function() contribute("CampfireContribution", "Logs", 100) end
})

Tab:CreateButton({
	Name = "Contribute 100 Stone to Campfire",
	Callback = function() contribute("CampfireContribution", "Stone", 100) end
})

Tab:CreateButton({
	Name = "Contribute 10 Logs to Bridge",
	Callback = function() contribute("BridgeContribution", "Logs", 10) end
})

Tab:CreateButton({
	Name = "Contribute 10 Stone to Bridge",
	Callback = function() contribute("BridgeContribution", "Stone", 10) end
})

Tab:CreateButton({
	Name = "Use Potion (Logs)",
	Callback = function() callRemote("UsePotion", "Logs") end
})

Tab:CreateButton({
	Name = "Use Potion (Stone)",
	Callback = function() callRemote("UsePotion", "Stone") end
})

Tab:CreateButton({
	Name = "Grab (Logs) Potion",
	Callback = function() callRemote("Shaman", "Logs") end
})

Tab:CreateButton({
	Name = "Grab (Stone) Potion",
	Callback = function() callRemote("Shaman", "Stone") end
})

--// Toggles
Tab:CreateToggle({
	Name = "Auto Break (Golden Axe / Pickaxe)",
	CurrentValue = false,
	Callback = function(v)
		autoBreak = v
	end
})

Tab:CreateToggle({
	Name = "Auto Campfire Contribute",
	CurrentValue = false,
	Callback = function(v)
		autoCampfire = v
	end
})

Tab:CreateToggle({
	Name = "Auto Bridge Contribute",
	CurrentValue = false,
	Callback = function(v)
		autoBridge = v
	end
})

Tab:CreateToggle({
	Name = "Auto Potion Use",
	CurrentValue = false,
	Callback = function(v)
		autoPotion = v
	end
})

Tab:CreateToggle({
	Name = "Auto Shaman Use",
	CurrentValue = false,
	Callback = function(v)
		autoShaman = v
	end
})

--// Auto loop
task.spawn(function()
	while true do
		if autoBreak then
			fireTool("Golden Axe")
			fireTool("Golden Pickaxe")
		end
		if autoCampfire then
			contribute("CampfireContribution", "Logs", 100)
			contribute("CampfireContribution", "Stone", 100)
		end
		if autoBridge then
			contribute("BridgeContribution", "Logs", 10)
			contribute("BridgeContribution", "Stone", 10)
		end
		if autoPotion then
			callRemote("UsePotion", "Logs")
			callRemote("UsePotion", "Stone")
		end
		if autoShaman then
			callRemote("Shaman", "Logs")
			callRemote("Shaman", "Stone")
		end
		task.wait(3)
	end
end)

fetchBreakables()
Rayfield:LoadConfiguration()
