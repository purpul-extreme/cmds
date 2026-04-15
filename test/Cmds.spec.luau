local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Cmds = require(ReplicatedStorage.Cmds)

return function()
	describe("RegisterCommand", function()
		beforeEach(function()
			Cmds.Reset()
		end)

		it("should register a command", function()
			expect(function()
				Cmds.RegisterCommand("test", {
					execute = function() end,
				})
			end).never.to.throw()
		end)

		it("should error if command is already registered", function()
			Cmds.RegisterCommand("dupe", { execute = function() end })
			expect(function()
				Cmds.RegisterCommand("dupe", { execute = function() end })
			end).to.throw()
		end)

		it("should error if alias is already taken", function()
			Cmds.RegisterCommand("cmd1", {
				aliases = { "t" },
				execute = function() end,
			})
			expect(function()
				Cmds.RegisterCommand("cmd2", {
					aliases = { "t" },
					execute = function() end,
				})
			end).to.throw()
		end)
	end)

	describe("SetPrefix", function()
		it("should change the prefix", function()
			expect(function()
				Cmds.SetPrefix("/")
			end).never.to.throw()
		end)
	end)
end
