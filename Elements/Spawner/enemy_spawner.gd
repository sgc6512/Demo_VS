extends Path2D


@onready var timer = %Timer
@onready var path_follow_2d = %PathFollow2D


@export var enemy_scene:PackedScene
@export var all_enemies:ResourceGroup

var enemy_list:Array[Enemy] = []


# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start()
	
	all_enemies.load_all_into(enemy_list)


func _on_timer_timeout():
	var new_enemy = enemy_scene.instantiate()
	var roll = 1
	if randf() >= 0.5:
		roll = 0
	new_enemy.enemy = enemy_list[roll]
	add_sibling(new_enemy)
	path_follow_2d.progress_ratio = randf()
	new_enemy.global_position = path_follow_2d.global_position
