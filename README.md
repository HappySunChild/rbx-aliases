# rbx-aliases
A utility module for manually converting aliases to relative paths.

### Example:
```luau
-- Script placed in ServerScriptService

local ReplicatedStorage = game:GetService "ReplicatedStorage"

local AliasConverter = require("path/to/alias-converter")

local converter = AliasConverter()
converter:registerAlias("shared", ReplicatedStorage)

local exampleAliasPath = "@shared/Hello"

print(converter:convertAliases(exampleAliasPath, script)) --> "../ReplicatedStorage/Hello"
```