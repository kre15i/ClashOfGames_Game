extends Control




func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)



func _on_Button_pressed():
	get_tree().change_scene("res://scenes/world1.tscn")


func _on_Button2_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")
