extends Node

func _ready():
	get_node("Menu/VBoxContainer/Start").connect("pressed", self, "on_start_pressed")
	get_node("Menu/VBoxContainer/Quit").connect("pressed", self, "on_quit_pressed")
	
func on_start_pressed():
	var gameScene = load("res://Scenes/MainScenes/GameScene.tscn").instance()
	get_node("Menu").queue_free()
	add_child(gameScene)
	
func on_quit_pressed():
	get_tree().quit()
	
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_tree().quit()
