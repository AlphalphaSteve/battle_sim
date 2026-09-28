local apollo = require("apollo")

local weapons = {
	{
		name = "sword",
		damage = {
			min = 5,
			max = 10,
		},
		speed = {
			min = 6,
			max = 8,
		},
		accuracy = {
			min = 6,
			max = 8,
		},
	},
	{
		name = "axe",
		damage = {
			min = 10,
			max = 15,
		},
		speed = {
			min = 1,
			max = 3,
		},
		accuracy = {
			min = 4,
			max = 6,
		},
	},
	{
		name = "dagger",
		damage = {
			min = 2,
			max = 6,
		},
		speed = {
			min = 9,
			max = 10,
		},
		accuracy = {
			min = 6,
			max = 8,
		},
	},
	{
		name = "bow",
		damage = {
			min = 5,
			max = 20,
		},
		speed = {
			min = 8,
			max = 10,
		},
		accuracy = {
			min = 2,
			max = 6,
		},
	},
	{
		name = "staff",
		damage = {
			min = 2,
			max = 4,
		},
		speed = {
			min = 9,
			max = 10,
		},
		accuracy = {
			min = 8,
			max = 10,
		},
	},
}
return weapons
