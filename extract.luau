local fs = require("@lune/fs")
local process = require("@lune/process")
local roblox = require("@lune/roblox")

local args = process.args
local placeFile = args[1]
local extractPath = args[2]
local outputPath = args[3]

local function recursiveExtract(inst, outputPath)
	local instPath = `{outputPath}/{inst.Name}`

	if #inst:GetChildren() > 0 then
		pcall(function() fs.writeDir(instPath) end)

		if inst:IsA("Script") then
			fs.writeFile(`{instPath}/init.server.luau`, inst.Source)
		elseif inst:IsA("LocalScript") then
			fs.writeFile(`{instPath}/init.client.luau`, inst.Source)
		elseif inst:IsA("ModuleScript") then
			fs.writeFile(`{instPath}/init.luau`, inst.Source)
		end

		for _, child in inst:GetChildren() do
			recursiveExtract(child, instPath)
		end
	else
		if inst:IsA("Script") then
			fs.writeFile(`{instPath}.server.luau`, inst.Source)
		elseif inst:IsA("LocalScript") then
			fs.writeFile(`{instPath}.client.luau`, inst.Source)
		elseif inst:IsA("ModuleScript") then
			fs.writeFile(`{instPath}.luau`, inst.Source)
		else
			return
		end
	end
end

local game = roblox.deserializePlace(fs.readFile(placeFile))
local extractTarget = game
for _, step in string.split(extractPath, ".") do
	extractTarget = extractTarget[step]
end

recursiveExtract(extractTarget, outputPath)
