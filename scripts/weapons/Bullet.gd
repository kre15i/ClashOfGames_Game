extends Spatial

export var speed = 70
export var damage = 1
const KILL_TIME = 2
var timer = 0

func _physics_process(delta):
	var forward_direction = global_transform.basis.y.normalized()
	global_translate(forward_direction * speed * delta)
	
	timer += delta
	if timer >= KILL_TIME:
		queue_free()


func _on_Area_body_entered(body: Node):
	print("hit")
	queue_free()

	if body.has_node("stats"):
		var stats_node : stats = body.find_node("stats")
		stats_node.take_hit(damage)
