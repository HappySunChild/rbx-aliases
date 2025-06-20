# rbx-aliases
A utility module for manually converting aliases to relative paths.

### Example:
```luau
-- Script placed in ServerScriptService

local exampleAliasPath = "@shared/Hello"

local AliasConverter = require("path/to/alias-converter")
local converter = AliasConverter:registerAlias("shared", game.ReplicatedStorage)

print(converter:convertAliases(exampleAliasPath, script)) --> "../ReplicatedStorage/Hello"
```