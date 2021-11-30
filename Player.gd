extends KinematicBody2D


var Bullet = preload("res://Bullet.tscn")
var run_speed = 150
var jump_speed = -420
var gravity = 1200

var velocity = Vector2()
var jumping = false

func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	var jump = Input.is_action_pressed("ui_select")
	var shoot = Input.is_action_just_pressed("mouse_click")
	
	if jump and is_on_floor():
		jumping = true
		velocity.y = jump_speed
	if right:
		velocity.x += run_speed
	if left:
		velocity.x -= run_speed
	if shoot:
		shooting()
	

func shooting():
	var b = Bullet.instance()
	b.start($Muzzle.global_position, $Muzzle.rotation)
	get_parent().add_child(b)

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	var dir = get_global_mouse_position() - global_position
	if dir.length() > 5:
		$Muzzle.rotation = dir.angle()
	if jumping and is_on_floor():
		jumping = false
	velocity = move_and_slide(velocity, Vector2(0, -1), true)
