extends KinematicBody


onready var camera = $pivot/Camera

var gravity = -30
var max_speed = 8
var mouse_sensitivity = 0.002 # radians/pixel

var velocity = Vector3()


func get_input():
	var input_dir = Vector3()
	# desired move in camera direction
	if Input.is_action_pressed("ui_up"):
		input_dir += -global_transform.basis.z
	if Input.is_action_pressed("ui_down"):
		input_dir += global_transform.basis.z
	if Input.is_action_pressed("ui_left"):
		input_dir += -global_transform.basis.x
	if Input.is_action_pressed("ui_right"):
		input_dir += global_transform.basis.x
	input_dir = input_dir.normalized()
	return input_dir


func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		$pivot.rotation.x = clamp($pivot.rotation.x, -1.2, 1.2)

func _physics_process(delta):
	velocity.y += gravity * delta
	var desired_velocity = get_input() * max_speed

	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	velocity = move_and_slide(velocity, Vector3.UP, true)