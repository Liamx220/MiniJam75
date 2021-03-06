extends KinematicBody2D

export (int) var speed = 400
export (int) var jump_speed = -150
export (int) var gravity = 300
export (int) var weight_int = 500
onready var weight_text = get_node("Weight")

var velocity = Vector2()

func _ready():
	weight_text.text = "Weight: " + str(weight_int)

func get_input():
	velocity.x = 0
	if Input.is_action_pressed("walk_right"):
		velocity.x -= 100
		
		$AnimatedSprite.play("leftWalk")
	if Input.is_action_pressed("walk_left"):
		velocity.x += 100
		$AnimatedSprite.play("rightWalk")

func _physics_process(delta):
	weight_text.text = "Weight: " + str(weight_int)
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed


func _on_Area2D_area_entered(area):
	if area.is_in_group("enemy"):
		get_tree().reload_current_scene() 
	if area.is_in_group("food"):
		weight_int -= 20
		area.queue_free()
