--// Listens to player chat for dev commands

local Players = game:GetService("Players")
local InfectionHandler = require(script.Parent.Modules:WaitForChild("InfectionHandler"))

--// Helper: find player by partial name or 'me'
local function getTargetPlayer(fromPlayer, nameArg)
	if not nameArg or nameArg == "" then return nil end
	if nameArg == "me" then return fromPlayer end

	nameArg = nameArg:lower()
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr.Name:lower():sub(1, #nameArg) == nameArg then
			return plr
		end
	end
	return nil
end

Players.PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(message)
		local args = message:lower():split(" ")
		local command = args[1]
		local targetArg = args[2]

		if not command then return end

		if command == "!infect" then
			local target = getTargetPlayer(player, targetArg)
			if target then
				InfectionHandler.InfectPlayer(target)
			else
				warn("Player not found!")
			end

		elseif command == "!cure" then
			local target = getTargetPlayer(player, targetArg)
			if target then
				InfectionHandler.CurePlayer(target)
			else
				warn("Player not found!")
			end

		elseif command == "!kill" then
			local target = getTargetPlayer(player, targetArg)
			if target then
				InfectionHandler.KillPlayer(target)
			else
				warn("Player not found!")
			end
		end
	end)
end)