local apollo = require("apollo")
local weapons = require("weapons")
local player = require("player")
local enemies = require("enemies")

local weapon = weapons[math.random(5)]
local playerLoaded = false
player.load(weapon)
local enemy = enemies.new()
print("Are you ready to generate your player?")
local quickSettup = io.read()
if quickSettup == "yes" or quickSettup == "Yes" or quickSettup == "y" or quickSettup == "Y" then
	print("Okay stats have been auto generated here they are:")
	print(string.format("Strength: %s", player.stats.strength))
	print(string.format("Speed: %s", player.stats.speed))
	print(string.format("Accuracy: %s", player.stats.accuracy))
	print("Would you like a sword, axe, dagger, bow, or staff?")
	weapon = io.read()
	if weapon == "sword" then
		player.weapon = weapons[1]
	elseif weapon == "axe" then
		player.weapon = weapons[2]
	elseif weapon == "dagger" then
		player.weapon = weapons[3]
	elseif weapon == "bow" then
		player.weapon = weapons[4]
	elseif weapon == "staff" then
		player.weapon = weapons[5]
	else
		player.weapon = weapons[math.random(5)]
		print("Thats an unrecognized weapon so your getting the a random one.")
	end
	print(string.format("Okay you chose the %s as your weapon of choice.", player.weapon.name))
	playerLoaded = true
end
if playerLoaded == true then
	local enemyFight = nil
	local playerFight = nil
	local fight = nil
	print("Oh no an enemy has appeared in your path!")
	local highStat = math.max(enemy.stats.strength, enemy.stats.speed, enemy.stats.accuracy)
	if highStat == enemy.stats.strength then
		print("He looks pretty strong are you sure you want to fight him?")
		enemyFight = math.random(6) <= 4
	elseif highStat == enemy.stats.speed then
		print("He looks pretty speedy its a tossup if he will fight or run away!")
		enemyFight = math.random(6) <= 3
	elseif highStat == enemy.stats.accuracy then
		print("This guy looks like as though he may be intelligent enough to settle things peacefully.")
		enemyFight = math.random(6) <= 2
	end
	print("Will you fight him?")
	playerFight = io.read()
	if playerFight == "yes" or playerFight == "Yes" or playerFight == "y" or playerFight == "Y" then
		playerFight = true
	elseif playerFight == "no" or playerFight == "No" or playerFight == "n" or playerFight == "N" then
		playerFight = false
	end
	if playerFight == true then
		if enemyFight == false then
			fight = math.random(6) >= 3
			if fight == true then
				print("You managed to draw the enemy into a brawl as it tried to flee!")
				fight = true
			else
				print("The enemy scrambles away as you attempt an attack!")
			end
		elseif enemyFight == true then
			print("You and the enemy both rush to attack each other!")
			fight = true
		end
	elseif playerFight == false then
		if enemyFight == false then
			print("You both run away from each other in cowardice!")
		elseif enemyFight == true then
			fight = math.random(6) >= 3
			if fight == true then
				print("You attempted to run but the enemy still drags you into battle!")
				fight = true
			elseif fight == false then
				print("You manage to escape as the enemy attemped to attack!")
			end
		end
	end
	if fight == true then
		if
			math.random(
				player.stats.accuracy * player.weapon.accuracy.min,
				player.stats.accuracy * player.weapon.accuracy.max
			)
			< math.random(
				enemy.stats.accuracy * enemy.weapon.accuracy.min,
				enemy.stats.accuracy * enemy.weapon.accuracy.max
			)
		then
			local damage = math.random(
				enemy.stats.strength * enemy.weapon.damage.min,
				enemy.stats.strength * enemy.weapon.damage.max
			)
			print("The enemy succesfully landed the first attack!")
			print(string.format("You took %s damage!", damage))
			player.stats.health = player.stats.health - damage
			if player.stats.health <= 0 then
				print("You were defeated by the enemy in a single blow! How weak!")
			else
				print(string.format("You have %s health remaining!", player.stats.health))
			end
		else
			print("The enemy attemped to attack first but missed!")
		end
	end
	local playerTurn
	if
		math.random(player.stats.speed * player.weapon.speed.min, player.stats.speed * player.weapon.speed.max)
		>= math.random(enemy.stats.speed * enemy.weapon.speed.min, enemy.stats.speed * enemy.weapon.speed.max)
	then
		playerTurn = true
	else
		playerTurn = false
	end

	while player.stats.health > 0 and enemy.stats.health > 0 do
		if playerTurn then
			if
				math.random(
					player.stats.accuracy * player.weapon.accuracy.min,
					player.stats.accuracy * player.weapon.accuracy.max
				)
				>= math.random(
					enemy.stats.accuracy * enemy.weapon.accuracy.min,
					enemy.stats.accuracy * enemy.weapon.accuracy.max
				)
			then
				local damage = math.random(
					player.stats.strength * player.weapon.damage.min,
					player.stats.strength * player.weapon.damage.max
				)
				print("You successfully landed a faster attack!")
				print(string.format("You dealt %s damage!", damage))

				enemy.stats.health = enemy.stats.health - damage

				if enemy.stats.health <= 0 then
					print("You defeated the enemy!")
				else
					print(string.format("The enemy has %s health remaining!", enemy.stats.health))
				end
			else
				print("You attempted a faster attack but missed!")
			end
			playerTurn = false
		else
			if
				math.random(
					enemy.stats.accuracy * enemy.weapon.accuracy.min,
					enemy.stats.accuracy * enemy.weapon.accuracy.max
				)
				>= math.random(
					player.stats.accuracy * player.weapon.accuracy.min,
					player.stats.accuracy * player.weapon.accuracy.max
				)
			then
				local damage = math.random(
					enemy.stats.strength * enemy.weapon.damage.min,
					enemy.stats.strength * enemy.weapon.damage.max
				)

				print("The enemy successfully landed a faster attack!")
				print(string.format("You took %s damage!", damage))

				player.stats.health = player.stats.health - damage

				if player.stats.health <= 0 then
					print("You were defeated by the enemy!")
				else
					print(string.format("You have %s health remaining!", player.stats.health))
				end
			else
				print("The enemy attempted a faster attack but missed!")
			end
			playerTurn = true
		end
	end
end
