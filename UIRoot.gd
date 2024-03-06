extends CanvasLayer


@onready var level_up_dialog:LevelUpDialog = %LevelUpDialog
@onready var player:Player = %Player

var level:float

func _ready():
	level = player.get_level()


func _process(_delta):
	if level < player.get_level():
		level = player.get_level()
		level_up_dialog.open(player.sheet)
