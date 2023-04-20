extends KinematicBody

var direction = Vector3.FORWARD
var movement_speed = 0
var walk_speed = 8
var run_speed = 15
var velocity = Vector3.ZERO
var acceleration = 6
var vertical_velocity = 0
var gravity = 25
var angular_acceleration = 7
var jump_magnitude = 15
var weight_on_ground = 7

onready var survived_timer = $Timer

onready var gun_controller = $Player/weaponController

func _ready():
	survived_timer.start()

func _input(event):
	if event is InputEventKey:
		pass

func _physics_process(delta):



	if Input.is_action_pressed("ui_up") ||  Input.is_action_pressed("ui_down") ||  Input.is_action_pressed("ui_left") ||  Input.is_action_pressed("ui_right"):
		var h_rot = $camroot/h.global_transform.basis.get_euler().y
		direction = Vector3(Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right"),
					0,
					Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")).rotated(Vector3.UP, h_rot).normalized()
				
		if Input.is_action_pressed("sprint"):
			movement_speed = run_speed
		else:
			movement_speed = walk_speed
	else:
		movement_speed = 0
		
	velocity = lerp(velocity, direction * movement_speed, delta * acceleration)
	move_and_slide(velocity + Vector3.UP * vertical_velocity -get_floor_normal() * weight_on_ground, Vector3.UP)
	
	if !is_on_floor():
		vertical_velocity -= gravity * delta
	else:
		vertical_velocity = 0
	
	$Player.rotation.y = lerp_angle($Player.rotation.y, atan2(-direction.x, -direction.z), delta * angular_acceleration)
	
	if is_on_floor():
		if Input.is_action_just_pressed("Jump"):
			vertical_velocity = jump_magnitude
	

#shoot shoot
func _process(delta):
	if Input.is_action_pressed("shoot"):
		gun_controller.shoot()
