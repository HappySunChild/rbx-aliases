local ServerScriptService = game:GetService "ServerScriptService"
local ReplicatedStorage = game:GetService "ReplicatedStorage"

local AliasConverter = require(ServerScriptService.Modules.AliasConverter)

local converter = AliasConverter()
converter:registerAlias("shared", ReplicatedStorage)

print(converter:convertAliases("@shared/Hello", script)) --> "../ReplicatedStorage/Hello"
