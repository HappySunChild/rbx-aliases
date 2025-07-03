export type AliasConverter = {
	setRoot: (AliasConverter, root: Instance) -> (),

	registerAlias: (AliasConverter, alias: string, reference: Instance) -> (),
	deregisterAlias: (AliasConverter, alias: string) -> (),

	getAbsolutePath: (AliasConverter, target: Instance) -> (string, { string }),
	getRelativePath: (AliasConverter, from: Instance, to: Instance) -> (string, { string }),

	convertAliases: (AliasConverter, path: string, relative: Instance) -> string,
}

type Self = AliasConverter & {
	_root: Instance,
	_aliases: { [string]: Instance },
}

local class = table.freeze {
	setRoot = function(self: Self, root: Instance)
		self._root = root
	end,

	registerAlias = function(self: Self, alias: string, reference: Instance)
		self._aliases[alias] = reference
	end,
	deregisterAlias = function(self: Self, alias: string)
		self._aliases[alias] = nil
	end,

	getAbsolutePath = function(self: Self, target: Instance): (string, { string })
		local root = self._root

		if not target:IsDescendantOf(root) then
			error(`{target} is not a descendant of root {root}.`)
		end

		local dirs = {}
		local current = target

		while current do
			table.insert(dirs, 1, current.Name)

			current = current.Parent
		end

		return table.concat(dirs, "/"), dirs
	end,
	getRelativePath = function(self: Self, from: Instance, to: Instance): (string, { string })
		local _, originPath = self:getAbsolutePath(from)
		local _, targetPath = self:getAbsolutePath(to)

		local common = 0

		for i = 1, math.min(#originPath, #targetPath) do
			if originPath[i] ~= targetPath[i] then
				break
			end

			common = i
		end

		local parentCount = #originPath - common - 1
		local relativeDirs = table.create(math.max(parentCount, 0), "..")

		if parentCount == 0 and common == 1 then -- sibling
			table.insert(relativeDirs, ".")
		elseif parentCount == -1 then -- descendant
			table.insert(relativeDirs, "@self")
		end

		for i = common + 1, #targetPath do
			table.insert(relativeDirs, targetPath[i])
		end

		return table.concat(relativeDirs, "/"), relativeDirs
	end,

	convertAliases = function(self: Self, path: string, relative: Instance): string
		local converted = string.gsub(path, "@([^/]+)", function(alias: string)
			if alias == "self" then
				return "@self"
			end

			local reference = self._aliases[alias]

			if reference == nil then
				error(`Unable to find alias reference for '{alias}'`)
			end

			local relativePath = self:getRelativePath(relative, reference)

			return relativePath
		end)

		return converted
	end,
}
local METATABLE = table.freeze { __index = class }

local function AliasConverter(initialRoot: Instance?): AliasConverter
	local newConverter: Self = setmetatable({
		_root = initialRoot or game,
		_aliases = {},
	}, METATABLE) :: any

	return newConverter
end

return AliasConverter
