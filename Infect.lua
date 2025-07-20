--// Dependencies
local Players = game:GetService("Players")
local InfectionHandler = require(game.ServerScriptService.Modules:WaitForChild("InfectionHandler"))

--// Constants
local PART = script.Parent

--// Touch Handler
local function onTouched(hit)
	local character = hit:FindFirstAncestorOfClass("Model")
	if not character then return end

	local player = Players:GetPlayerFromCharacter(character)
	if not player then return end

	if InfectionHandler.IsPlayerInfected(player) then return end

	InfectionHandler.InfectPlayer(player)
end

--// Functions
PART.Touched:Connect(onTouched)