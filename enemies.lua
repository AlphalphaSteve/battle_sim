local apollo = require("apollo")
local weapons = require("weapons")

local enemies = {}

function enemies.new()
	local enemy = {
		stats = {
			health = 100,
			points = 20,
			strength = 0,
			speed = 0,
			accuracy = 0,
		},
		weapon = nil,
	}
	local startPoints = enemy.stats.points
	while enemy.stats.points >= 0 do
		enemy.stats.strength = enemy.stats.strength + math.random(startPoints / 2)
		enemy.stats.points = enemy.stats.points - enemy.stats.strength
		enemy.stats.speed = enemy.stats.speed + math.random(startPoints / 2)
		enemy.stats.points = enemy.stats.points - enemy.stats.speed
		enemy.stats.accuracy = enemy.stats.accuracy + math.random(startPoints / 2)
		enemy.stats.points = enemy.stats.points - enemy.stats.accuracy
	end
	enemy.weapon = weapons[math.random(5)]
	return enemy
end

return enemies
