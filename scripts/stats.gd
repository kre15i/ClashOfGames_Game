extends Node

class_name stats
export var max_HP = 3
var current_HP = max_HP
signal you_died

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func take_hit(damage):
	current_HP -= 1
	print("I'm hit")

	if current_HP <= 0:
		die()

func die():
	emit_signal("you_died")
	queue_free()
	

