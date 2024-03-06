extends Area2D

@export var enemy:Enemy

var health:float

@onready var sprite_2d = %Sprite2D

var player:CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready():
	# Grab enemy attributes from the data model
	sprite_2d.set_modulate(enemy.color)
	# Grab player node from group
	player = get_tree().get_nodes_in_group("player")[0]
	# Set local health value
	health = enemy.health
	
	add_to_group("enemy_group")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Move towards player
	var direction = global_position.direction_to(player.global_position)
	global_position += direction * enemy.speed * delta


func take_damage(damage_taken):
	health -= damage_taken
	if health <= 0:
		player.get_xp(enemy.xp)
		queue_free()


func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(enemy.damage)
		queue_free()
