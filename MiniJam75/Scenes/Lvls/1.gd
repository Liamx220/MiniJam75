extends Node2D

var reload_times = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(10):
		if reload_times == 1:
			
			get_tree().reload_current_scene()
			reload_times += 1

		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
