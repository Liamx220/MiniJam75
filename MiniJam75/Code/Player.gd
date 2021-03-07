extends KinematicBody2D

export (int) var speed = 400
export (int) var jump_speed = -150
export (int) var gravity = 300
onready var weight_int_num = get_node("/root/Weight")
onready var weight_text = get_node("Weight")

var velocity = Vector2()

func _ready():
	
	
	weight_text.text = "Weight: " + str(weight_int_num.Weight)
	

func get_input():
	velocity.x = 0
	if Input.is_action_pressed("walk_right"):
		velocity.x -= 100
		
		$AnimatedSprite.play("leftWalk")
	if Input.is_action_pressed("walk_left"):
		velocity.x += 100
		$AnimatedSprite.play("rightWalk")

func _physics_process(delta):
	var weight_text = get_node("Weight")
	weight_text.text = "Weight: " + str(weight_int_num.Weight)
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			$jump.play()
			velocity.y = jump_speed


func _on_Area2D_area_entered(area):
	if area.is_in_group("enemy"):
		get_tree().reload_current_scene()
	if area.is_in_group("food"):
		$eat.play()
		weight_int_num.Weight -= 5
		area.queue_free()
	if area.is_in_group("10"):
		$eat.play()
		weight_int_num.Weight -= 10
		area.queue_free()
	if area.is_in_group("bad5"):
		weight_int_num.Weight += 10
		$eat.play()
		area.queue_free()
	if area.is_in_group("door"):
		
		get_tree().change_scene("res://Scenes/Lvls/2.tscn")
	if area.is_in_group("door2"):
		get_tree().change_scene("res://Scenes/Lvls/level3.tscn")
	if area.is_in_group("door3"):
		get_tree().change_scene("res://Scenes/Lvls/4.tscn")
	if area.is_in_group("door4"):
		get_tree().change_scene("res://Scenes/Lvls/5.tscn")
	if area.is_in_group("door5"):
		get_tree().change_scene("res://Scenes/Lvls/6.tscn")


func _on_CollisionShape2D_tree_entered(area):
	if area.is_in_group("enemy"):
		get_tree().reload_current_scene()
