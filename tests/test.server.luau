local ServerScriptService = game:GetService "ServerScriptService"

local AliasConverter = require(ServerScriptService.AliasConverter)

local tests = ServerScriptService.Tests

local converter = AliasConverter()
converter:registerAlias("tests", tests)
print(converter:convertAliases("@tests/Module", workspace.Baseplate))
