_G.love = require("love")

function love.load()
	Num = 10
	Space = 1000 / Num

	CenterX = love.graphics.getWidth() / 2
	CenterY = love.graphics.getHeight() / 2

	Ax = CenterX - (((Num - 1) / 2) * Space)
	Ay = CenterY - (((Num - 1) / 2) * Space)

	Points = {}

	for j = 1, Num, 1 do
		local tableName = "Points" .. (Num - j + 1)
		_G[tableName] = {}

		for i = 0, Num - j, 1 do
			table.insert(_G[tableName], { Ax + i * Space, Ay })
		end

		Ax = Ax + Space / 2
		Ay = Ay + Space
	end

	cameraZoom = 1
	cameraX, cameraY = 0, 0
	moveSpeed = 400
	zoomSpeed = 0.1
end

function love.update(dt)
	if love.keyboard.isDown("left") then
		cameraX = cameraX + moveSpeed * dt
	elseif love.keyboard.isDown("right") then
		cameraX = cameraX - moveSpeed * dt
	end

	if love.keyboard.isDown("up") then
		cameraY = cameraY + moveSpeed * dt
	elseif love.keyboard.isDown("down") then
		cameraY = cameraY - moveSpeed * dt
	end
end

function love.keypressed(key)
	if key == "=" or key == "+" then
		local oldZoom = cameraZoom
		cameraZoom = cameraZoom + zoomSpeed
		local zoomFactor = cameraZoom / oldZoom
		cameraX = cameraX * zoomFactor
		cameraY = cameraY * zoomFactor
	elseif key == "-" then
		local oldZoom = cameraZoom
		cameraZoom = cameraZoom - zoomSpeed
		if cameraZoom < 1 then
			cameraZoom = 1
		end
		local zoomFactor = cameraZoom / oldZoom
		cameraX = cameraX * zoomFactor
		cameraY = cameraY * zoomFactor
	end
end

function love.draw()
	love.graphics.push()
	love.graphics.translate(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
	love.graphics.scale(cameraZoom, cameraZoom)
	love.graphics.translate(-love.graphics.getWidth() / 2 + cameraX, -love.graphics.getHeight() / 2 + cameraY)

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

	love.graphics.pop()
end
