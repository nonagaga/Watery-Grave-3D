extends Node

export var Globals = {"sensitivity" : 0.03}

func get_Globals():
	return Globals

func _ready():
	get_node("Menu/VBoxContainer/Start").connect("pressed", self, "on_start_pressed")
	get_node("Menu/VBoxContainer/Quit").connect("pressed", self, "on_quit_pressed")
	get_node("Menu/VBoxContainer/Options").connect("pressed", self, "on_options_pressed")
	
func on_start_pressed():
	var gameScene = load("res://Scenes/MainScenes/GameScene.tscn").instance()
	#var gameScene = load("res://Scenes/MainScenes/TestScene.tscn").instance()
	get_node("Menu").queue_free()
	add_child(gameScene)
	
func on_quit_pressed():
	get_tree().quit()
	
func on_options_pressed():
	var options = load("res://Scenes/MainScenes/Options.tscn").instance()
	add_child(options)
	
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_tree().quit()
