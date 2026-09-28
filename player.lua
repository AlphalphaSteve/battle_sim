local apollo = require("apollo")
local weapons = require("weapons")

local player = {
	stats = {
		health = 100,
		points = 20,
		strength = 0,
		speed = 0,
		accuracy = 0,
	},
	weapon = nil,
}

function player.load(weapon)
	local startPoints = player.stats.points
	while player.stats.points >= 0 do
		player.stats.strength = player.stats.strength + math.random(startPoints / 2)
		player.stats.points = player.stats.points - player.stats.strength
		player.stats.speed = player.stats.speed + math.random(startPoints / 2)
		player.stats.points = player.stats.points - player.stats.speed
		player.stats.accuracy = player.stats.accuracy + math.random(startPoints / 2)
		player.stats.points = player.stats.points - player.stats.accuracy
	end
	player.weapon = weapon
end

function player.update(dt) end

function player.draw() end

return player
