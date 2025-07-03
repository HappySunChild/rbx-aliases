local ServerScriptService = game:GetService "ServerScriptService"
local ReplicatedStorage = game:GetService "ReplicatedStorage"

local AliasConverter = require(ServerScriptService.Modules.AliasConverter)

local converter = AliasConverter()
converter:registerAlias("shared", ReplicatedStorage)

local exampleAliasPath = "@shared/Hello"

print(converter:convertAliases(exampleAliasPath, script)) --> "../ReplicatedStorage/Hello"
