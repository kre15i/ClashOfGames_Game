extends Spatial

export(PackedScene) var Enemy
onready var timer = $Timer

export var num_enemies = 3
export var seconds_between_spawns = 2
var enemies_killed_this_wave

var enemies_remaining_to_spawn

var waves
var current_wave : Wave
var current_wave_number = -1

func _ready():
	waves = $Waves.get_children()
	start_next_wave()

func start_next_wave():
	enemies_killed_this_wave = 0
	print("next wave!")
	current_wave_number += 1
	current_wave = waves[current_wave_number]
	enemies_remaining_to_spawn = current_wave.num_enemies
	timer.wait_time = current_wave.seconds_between_spawns
	timer.start()

func _on_Timer_timeout():
	if enemies_remaining_to_spawn:
		#spawn
		var enemy = Enemy.instance()
		var scene_root = get_parent()
		scene_root.add_child(enemy)
		enemies_remaining_to_spawn -= 1
	else:
		if enemies_killed_this_wave == current_wave_number:
			start_next_wave()
