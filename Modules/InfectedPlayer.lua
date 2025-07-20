--// Manages infection state and behavior per player
local Teams = game:GetService("Teams")
local Debris = game:GetService("Debris")
local Constants = require(script.Parent:WaitForChild("Constants"))
local Maid = require(script.Parent:WaitForChild("Maid"))

local InfectedPlayer = {}
InfectedPlayer.__index = InfectedPlayer

--// Constructor
function InfectedPlayer.new(player)
	assert(player and player:IsA("Player"), "[InfectedPlayer] Invalid player")

	local self = setmetatable({}, InfectedPlayer)

	self.Player = player
	self.UserId = player.UserId
	self.Stage = 0
	self.Timer = 0
	self.Active = true
	self.Maid = Maid.new()

	-- Switch player to infected team
	local infectedTeam = Teams:FindFirstChild(Constants.INFECTED_TEAM_NAME)
	if infectedTeam then
		self.Player.Team = infectedTeam
	else
		warn("[InfectedPlayer] Infected team not found!")
	end

	print("[InfectedPlayer] Player " .. player.Name .. " infected at Stage 0")

	return self
end

--// Called every second by InfectionHandler tick loop
function InfectedPlayer:Step()
	if not self.Active then return end

	self.Timer += 1
	if self.Timer >= Constants.STAGE_INTERVAL then
		self.Timer = 0

		if self.Stage < Constants.MAX_STAGE then
			self.Stage += 1
			print(string.format("[InfectedPlayer] %s mutated to Stage %d", self.Player.Name, self.Stage))
			self:ApplyEffects()
		end
	end
end

--// Spawns parasite effect on player character root
function InfectedPlayer:ApplyEffects()
	local character = self.Player.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")
	if not root then return end

	local emitter = Instance.new("ParticleEmitter")
	emitter.Name = "ParasiteEffect"
	emitter.Rate = 10 * self.Stage
	emitter.Lifetime = NumberRange.new(1)
	emitter.Parent = root

	self.Maid:Give(emitter)

	-- Safety cleanup in case particle lasts longer than effect duration
	task.delay(Constants.EFFECT_DURATION, function()
		if emitter and emitter.Parent then
			self.Maid:DoCleaning()
		end
	end)
end

--// Cure player: stops infection and returns to survivor team
function InfectedPlayer:Cure()
	if not self.Active then return end
	self.Active = false

	self.Maid:DoCleaning()

	local survivorTeam = Teams:FindFirstChild(Constants.SURVIVOR_TEAM_NAME) or Teams:GetTeams()[1]
	if survivorTeam then
		self.Player.Team = survivorTeam
	else
		warn("[InfectedPlayer] Survivor team not found!")
	end

	print("[InfectedPlayer] Player " .. self.Player.Name .. " cured")
end

--// Kill player and cure them
function InfectedPlayer:Kill()
	local character = self.Player.Character
	if character then
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.Health = 0
		end
	end

	self:Cure()
end

--// Clean up resources explicitly
function InfectedPlayer:Destroy()
	self.Maid:Destroy()
	self.Active = false
end

return InfectedPlayer