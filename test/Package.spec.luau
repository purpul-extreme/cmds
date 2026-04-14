local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Package = require(ReplicatedStorage.Package)

return function()
	describe("Add", function()
		it("should add two numbers", function()
			expect(Package.Add(2, 3)).to.equal(5)
		end)
	end)
end
