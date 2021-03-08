extends KinematicBody2D

export var move_speed = 75
export var gravity = 10
export var less_gravity = 5
export var jump_force = 200
var velo = Vector2()
var drag = 0.5
var dead = false
const jump_buffer = 0.04
var time_pressed_jump = 0.0
var time_left_ground = 0.0
var last_grounded = false

var facing_right = true
onready var weight_int_num = get_node("/root/Weight")
onready var weight_text = get_node("Weight")


var velocity = Vector2()

func _ready():
	
	get_tree().call_group("need_player_ref", "set_player", self)
	
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
	if weight_int_num.Weight > 200 or weight_int_num.Weight < 150 :
		get_node("Weight").add_color_override("font_color", Color(1,0,0))
	if weight_int_num.Weight >= 150 and weight_int_num.Weight  < 200 :
		get_node("Weight").add_color_override("font_color", Color(0,255,0))
		
		
	var weight_text = get_node("Weight")
	weight_text.text = "Weight: " + str(weight_int_num.Weight)
	var move_vec = Vector2()
	if !dead:
		if Input.is_action_pressed("ui_left"):
			move_vec.x -= 1
			$AnimatedSprite.play("leftWalk")
		if Input.is_action_pressed("ui_right"):
			move_vec.x += 1
			$AnimatedSprite.play("rightWalk")
	
	velo += move_vec * move_speed - drag * Vector2(velo.x, 0)
	
	var cur_grounded = is_on_floor()
	if !cur_grounded and last_grounded:
		time_left_ground = get_cur_time()
	
	var will_jump = false
	var pressed_jump = Input.is_action_just_pressed("jump")
	
	if pressed_jump:
		
		time_pressed_jump = get_cur_time()
	
	if (pressed_jump and cur_grounded):
		jump()
	elif (!last_grounded and cur_grounded and get_cur_time() - time_pressed_jump < jump_buffer):
		jump()
	elif pressed_jump and get_cur_time() - time_left_ground < jump_buffer:
		jump()
	
	if Input.is_action_pressed("jump"):
		velo.y += less_gravity
	else:
		velo.y += gravity
	
	if cur_grounded and velo.y > 10:
		velo.y = 10
	
	move_and_slide(velo, Vector2.UP)
	
	#if move_vec.x > 0.0 and !facing_right:
		#flip()
	#elif move_vec.x < 0.0 and facing_right:
		#flip()
	

	
	last_grounded = cur_grounded


func _on_Area2D_area_entered(area):
	if area.is_in_group("enemy"):
		get_tree().reload_current_scene()
	if area.is_in_group("food"):
		
		weight_int_num.Weight -= 5
		area.queue_free()
	if area.is_in_group("10"):
		
		weight_int_num.Weight -= 10
		area.queue_free()
	if area.is_in_group("bad5"):
		weight_int_num.Weight += 10
		
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
	if area.is_in_group("Dentist"):
		if weight_int_num.Weight >= 150 and weight_int_num.Weight  < 200 :
			get_tree().change_scene("res://final.tscn")
			
		elif weight_int_num.Weight > 200 or weight_int_num.Weight < 150:
			var no = get_node("Control")
			no.visible = true

func _on_CollisionShape2D_tree_entered(area):
	if area.is_in_group("enemy"):
		get_tree().reload_current_scene()


func _on_Button_button_down():
	get_tree().reload_current_scene()
	get_tree().change_scene("res://Scenes/Lvls/1.tscn")


func _on_next_button_down():
	get_tree().change_scene("res://tutorial2.tscn")
	
func jump():
	$jump.play()
	if dead:
		return
	velo.y = -jump_force

func get_cur_time():
	return OS.get_ticks_msec() / 1000.0


