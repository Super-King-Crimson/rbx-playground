--!strict
local rs = game:GetService("ReplicatedStorage")
local shared = rs:FindFirstChild("Shared")
local hello = require(shared.Hello)

hello()
