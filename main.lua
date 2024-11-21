_G.love = require("love")

function love.load()
	Num = 8
	Space = 1000 / Num

	CenterX = love.graphics.getWidth() / 2
	CenterY = love.graphics.getHeight() / 2

	Ax = CenterX - (((Num - 1) / 2) * Space)
	Ay = CenterY - (((Num - 1) / 2) * Space)

	for j = 1, Num, 1 do
		local tableName = "Points" .. (Num - j + 1)
		_G[tableName] = {}

		for i = 0, Num - j, 1 do
			table.insert(_G[tableName], { Ax + i * Space, Ay })
		end

		Ax = Ax + Space / 2
		Ay = Ay + Space
	end
end
function love.update(dt) end

function love.draw()
	for j = Num, 2, -1 do
		local currentTableName = "Points" .. j
		local nextTableName = "Points" .. (j - 1)

		local currentPoints = _G[currentTableName]
		local nextPoints = _G[nextTableName]

		if currentPoints and nextPoints then
			for _, currentPoint in ipairs(currentPoints) do
				local x1, y1 = currentPoint[1], currentPoint[2]

				for _, nextPoint in ipairs(nextPoints) do
					local x2, y2 = nextPoint[1], nextPoint[2]

					love.graphics.line(x1, y1, x2, y2)
				end
			end
		end
	end
end
