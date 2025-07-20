--// Manages infection states and global tick updates
local Players = game:GetService("Players")
local InfectedPlayer = require(script.Parent:WaitForChild("InfectedPlayer"))

local InfectionHandler = {}
local Infected = {}

--// Infect player if not infected already
function InfectionHandler.InfectPlayer(player)
	if not player or Infected[player.UserId] then return end

	Infected[player.UserId] = InfectedPlayer.new(player)
end

--// Cure player if infected
function InfectionHandler.CurePlayer(player)
	local obj = Infected[player.UserId]
	if obj then
		obj:Cure()
		Infected[player.UserId] = nil
	end
end

--// Kill player if infected
function InfectionHandler.KillPlayer(player)
	local obj = Infected[player.UserId]
	if obj then
		obj:Kill()
		Infected[player.UserId] = nil
	end
end

--// Check infection status
function InfectionHandler.IsPlayerInfected(player)
	return Infected[player.UserId] ~= nil
end

--// Cleanup infected data when player leaves
Players.PlayerRemoving:Connect(function(player)
	local obj = Infected[player.UserId]
	if obj then
		obj:Destroy()
		Infected[player.UserId] = nil
	end
end)

--// Global tick loop to progress infection stages
task.spawn(function()
	while true do
		for _, obj in pairs(Infected) do
			obj:Step()
		end
		task.wait(1)
	end
end)

return InfectionHandler