extends Control
export (bool) var is_paused = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	
	if Input.is_action_pressed("esc") and is_paused == false:
		get_tree().paused = true
		visible = true
		is_paused = true
		
		



func _on_Button3_button_down():
	if is_paused == true:
		print("unpause")
		get_tree().paused = false
		visible = false
		is_paused = false
		


func _on_Button2_button_down():
	get_tree().change_scene("res://tutorial2.tscn")
