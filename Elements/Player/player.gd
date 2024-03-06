class_name Player
extends CharacterBody2D


# Get player stats from dictionary
@onready var sheet:StatSheet = StatSheet.new()


@onready var attack_timer = %AttackTimer
@onready var regen_timer = %RegenTimer


@export var projectile:PackedScene


func _ready():
	pass


func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	
	if direction_x or direction_y:
		velocity.x = direction_x * sheet.Stats["speed"]
		velocity.y = direction_y * sheet.Stats["speed"]
	else:
		velocity.x = move_toward(velocity.x, 0, sheet.Stats["speed"])
		velocity.y = move_toward(velocity.y, 0, sheet.Stats["speed"])

	move_and_slide()


func take_damage(damage_taken):
	sheet.hurt(damage_taken)


func get_xp(amount:float):
	sheet.increase_xp(amount)
	# Update timer values
	attack_timer.wait_time = 1 / sheet.Stats["attack_speed"]


func get_level():
	return sheet.xp["level"]


func _on_timer_timeout():
	# Spawn a new projectile
	var angles = projectile_spread()
	for x in sheet.Stats["projectile_count"]:
		var new_projectile = projectile.instantiate()
		new_projectile.setup(global_position, sheet.Stats["damage"], angles[x], sheet.Stats["arc"])
		add_sibling(new_projectile)


func projectile_spread():
	if sheet.Stats["projectile_count"] == 1:
		return [sheet.Stats["arc"] / 2]
	
	var step = sheet.Stats["arc"] / (sheet.Stats["projectile_count"] - 1)
	var result = []
	for i in sheet.Stats["projectile_count"]:
		result.append(i * step)
	return result


func _on_regen_timer_timeout():
	if sheet.Health["health"] < sheet.Stats["max_health"]:
		sheet.heal(sheet.Stats["regen"])
