local ServerScriptService = game:GetService "ServerScriptService"
local ReplicatedStorage = game:GetService "ReplicatedStorage"

local exampleAliasPath = "@shared/Hello"

local AliasConverter = require(ServerScriptService.AliasConverter)

local converter = AliasConverter()
converter:registerAlias("shared", ReplicatedStorage)

print(converter:convertAliases(exampleAliasPath, script)) --> "../ReplicatedStorage/Hello"
