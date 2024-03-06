class_name StatSheet


var Stats = {
	"max_health": 100,
	"regen": 1,
	"speed": 300,
	"attack_speed": 1,
	"damage": 10,
	"projectile_count": 4,
	"arc": 30
}


var Health = {
	"health": 100
}


var xp = {
	"xp": 0,
	"maxXp": 10,
	"level": 1
}


func heal(amount:float):
	Health["health"] += amount


func hurt(amount:float):
	Health["health"] -= amount


func increase_stat(stat:String, amount:float):
	Stats[stat] += amount


func decrease_stat(stat:String, amount:float):
	Stats[stat] -= amount


func mult_stat(stat:String, amount:float):
	Stats[stat] *= amount


func increase_xp(amount:float):
	xp["xp"] += amount
	if xp["xp"] >= xp["maxXp"]:
		level_up()


func level_up():
	xp["xp"] = 0
	xp["maxXp"] *= 1.2
	xp["level"] += 1
