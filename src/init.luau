local Players = game:GetService("Players")

--- Defines the structure for a registered command.
type CommandData = {
	aliases: { string }?,
	execute: (caller: Player, ...any) -> (),
}

local currentPrefix = "!"
local commandRegistry: { [string]: CommandData } = {}
local commandAliases: { [string]: string } = {}
local processedPlayers: { [Player]: boolean } = {}

local Cmds = {}

--[[
    Checks if the message starts with the prefix, then finds and runs the
    matching command, resolving aliases if needed.

    @param message string -- The chat message.
    @param player Player  -- The player who sent it.
]]
local function processMessage(message: string, player: Player)
	if message:sub(1, #currentPrefix) ~= currentPrefix then
		return
	end

	local parts = {}
	for match in message:sub(#currentPrefix + 1):gmatch("%S+") do
		table.insert(parts, match)
	end

	if #parts == 0 then
		return
	end

	local firstPart = parts[1]
	local commandData: CommandData? = commandRegistry[firstPart] or commandRegistry[commandAliases[firstPart]]
	if commandData then
		task.spawn(commandData.execute, player, table.unpack(parts, 2))
	end
end

--[[
    Connects the player's chat to the command system on join.
    Guards against being connected more than once.
]]
local function onPlayerAdded(player: Player)
	if processedPlayers[player] then
		return
	end
	processedPlayers[player] = true
	player.Chatted:Connect(function(message: string)
		processMessage(message, player)
	end)
end

--[[
    Removes the player from the processed table when they leave.
]]
local function onPlayerRemoving(player: Player)
	processedPlayers[player] = nil
end

--[[
    Updates the prefix that all chat commands must start with.

    @param prefix string -- The new prefix (e.g. "!", "/").
]]
function Cmds.SetPrefix(prefix: string)
	currentPrefix = prefix
end

--[[
    Registers a command by name and maps any aliases to it.
    Errors if the name or any alias is already taken.

    @param name string      -- The command name.
    @param data CommandData -- The command definition.
]]
function Cmds.RegisterCommand(name: string, data: CommandData)
	if commandRegistry[name] then
		error(`[Cmds]: Command '{name}' is already registered`)
	end

	local aliases = data.aliases or {}

	for _, alias in aliases do
		if commandAliases[alias] then
			error(`[Cmds]: Alias '{alias}' is already associated with a command`)
		end
	end

	commandRegistry[name] = data

	for _, alias in aliases do
		commandAliases[alias] = name
	end
end

Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)

for _, player in Players:GetPlayers() do
	onPlayerAdded(player)
end

return Cmds
