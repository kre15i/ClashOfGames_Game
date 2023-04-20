extends KinematicBody


onready var nav = $"../NavigationMeshInstance" as Navigation
onready var player = $"../player" as KinematicBody
var navAgent : NavigationAgent
var attacking = false
export var speed = 1

var path = [] 

func _ready():
	navAgent = $NavigationAgent
	navAgent.connect("velocity_computed", self, "_on_velocity_computed")
#	path = nav.get_simple_path(global_transform.origin, player.global_transform.origin)
#	print()

func _physics_process(delta):
	if navAgent.is_navigation_finished():
		return
	var targetPos = navAgent.get_next_location()
	var direction = global_transform.origin.direction_to(targetPos)
	var velocity = direction * speed
	
	move_and_slide(velocity,Vector3.UP)


func _on_velocity_computed():
	pass

func _on_Timer_timeout():
	navAgent.set_target_location(get_tree().get_nodes_in_group("player")[0].global_transform.origin)


func _on_Area_body_entered(body):
	if body == player:
		Global.player_HP -= 1
		print("entered ", body)
	if body == player and Global.player_HP == 0:
		print("player died")
		get_tree().change_scene("res://scenes/Dead.tscn")


func _on_stats_you_died():
	queue_free()
