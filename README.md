<h1 align="center">Cmds</h1>
<p align="center">A simple admin command system.</p>

## Installation
Download the latest `.rbxm` file from [releases](https://github.com/purpul-extreme/Cmds/releases) and drag it into Roblox Studio.

## Usage
```lua
local Cmds = require(ReplicatedStorage.Cmds)

Cmds.RegisterCommand("kick", {
    aliases = { "k" },
    execute = function(player, target)
        -- kick logic
    end,
})
```

## API
| Function | Description |
|---|---|
| `Cmds.RegisterCommand(name, data)` | Registers a command with optional aliases |
| `Cmds.SetPrefix(prefix)` | Sets the command prefix (default `!`) |
