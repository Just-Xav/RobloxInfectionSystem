--// Utility for automatic resource cleanup

local Maid = {}
Maid.__index = Maid

function Maid.new()
	return setmetatable({ _tasks = {} }, Maid)
end

--// Adds a task to the cleanup list
function Maid:Give(task)
	assert(task ~= nil, "[Maid] Cannot give nil task")
	table.insert(self._tasks, task)
	return task
end

--// Cleans up all tasks
function Maid:DoCleaning()
	for _, task in ipairs(self._tasks) do
		if typeof(task) == "RBXScriptConnection" then
			task:Disconnect()
		elseif typeof(task) == "Instance" then
			if task and task.Parent then
				task:Destroy()
			end
		elseif typeof(task) == "function" then
			task()
		end
	end
	self._tasks = {}
end

--// Completely destroys the Maid and cleans tasks
function Maid:Destroy()
	self:DoCleaning()
	setmetatable(self, nil)
end

return Maid