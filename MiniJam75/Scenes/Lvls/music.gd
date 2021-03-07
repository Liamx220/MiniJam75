extends AudioStreamPlayer2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _ready():
	_music()

# Called when the node enters the scene tree for the first time.
func _music():
	stream = load("res://sounds/Song_for_MiniJam75.wav")
	
	volume_db = -6
	playing = true
	


