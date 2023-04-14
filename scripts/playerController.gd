extends KinematicBody

var direction = Vector3.FORWARD
var movement_speed = 0
var walk_speed = 5
var run_speed = 10
var velocity = Vector3.ZERO
var acceleration = 6
var vertical_velocity = 0
var gravity = 20
var angular_acceleration = 7

func _input(event):
	if event is InputEventKey:
		pass

func _physics_process(delta):
	var h_rot = $camroot/h.global_transform.basis.get_euler().y
	
	direction = Vector3(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
				0,
				Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")).rotated(Vector3.UP, h_rot).normalized()

	
	if Input.is_action_pressed("ui_up") ||  Input.is_action_pressed("ui_down") ||  Input.is_action_pressed("ui_left") ||  Input.is_action_pressed("ui_right"):
		if Input.is_action_pressed("sprint"):
			movement_speed = run_speed
		else:
			movement_speed = walk_speed
	else:
		movement_speed = 0
		
	velocity = lerp(velocity, direction * movement_speed, delta * acceleration)
	move_and_slide(velocity + Vector3.DOWN * vertical_velocity, Vector3.UP)
	
	if !is_on_floor():
		vertical_velocity += gravity * delta
	else:
		vertical_velocity = 0
	
	$model.rotation.y = lerp_angle($model.rotation.y, atan2(direction.x, direction.z), delta * angular_acceleration)
