class_name Projectile
extends Area2D


@export var SPEED:float = 400
@export var damage:float = 10
@export var _offset:float = 0


var direction:Vector2 = Vector2.LEFT
func _ready():
	# Find closest enemy out of all enemies and target it
	var distance = 99999999
	
	var enemies = get_tree().get_nodes_in_group("enemy_group")
	
	for enemy in enemies:
		var distance_to = global_position.distance_to(enemy.global_position)
		if distance_to < distance:
			distance = distance_to
			direction = global_position.direction_to(enemy.global_position)


func _process(delta):
	global_position += direction.rotated(deg_to_rad(_offset)) * SPEED * delta


func _on_area_entered(area):
	var enemies = get_tree().get_nodes_in_group("enemy_group")

	if area.has_method("take_damage") and enemies.has(area):
		area.take_damage(damage)
		queue_free()


# Allows setting initial values on projectile creation
func setup(position_init:Vector2, damage_init:float, offset:float, arc:float):
	global_position = position_init
	damage = damage_init
	_offset = (-arc / 2) + offset
