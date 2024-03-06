class_name LevelUpDialog
extends PanelContainer


@onready var button = %Button
@onready var button_2 = %Button2
@onready var button_3 = %Button3


@export var percentages:Array = [1.1, 1.15, 1.3, 1.5]


var _player_sheet:StatSheet
var shuffled_keys:Array = []
var rarity:int = 0

func _ready():
	pass # Replace with function body.


func open(sheet:StatSheet):
	show()
	get_tree().paused = true
	
	_player_sheet = sheet
	
	# Shuffle the keys to get a random order
	shuffled_keys = sheet.Stats.keys()
	shuffled_keys.shuffle()
	
	# Choose a random percentage value to upgrade by
	match randf():
		var roll when roll <= 0.4:
			rarity = 0
		var roll when roll <= 0.7:
			rarity = 1
		var roll when roll <= 0.9:
			rarity = 2
		var roll when roll <= 1:
			rarity = 3
	
	var format_string = "Upgrade %s, by %s"
	button.text = format_string % [shuffled_keys[0], percentages[rarity]]
	button_2.text = format_string % [shuffled_keys[1], percentages[rarity]]
	button_3.text = format_string % [shuffled_keys[2], percentages[rarity]]


func _on_button_pressed():
	_player_sheet.mult_stat(shuffled_keys[0], percentages[rarity])
	get_tree().paused = false
	hide()


func _on_button_2_pressed():
	_player_sheet.mult_stat(shuffled_keys[1], percentages[rarity])
	get_tree().paused = false
	hide()


func _on_button_3_pressed():
	_player_sheet.mult_stat(shuffled_keys[2], percentages[rarity])
	get_tree().paused = false
	hide()
