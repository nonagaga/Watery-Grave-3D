extends Control

onready var globals = $"/root/SceneManager".get_Globals()

func _on_Sensitivity_Adjustment_value_changed(value):
	globals["sensitivity"] = value
	print(globals["sensitivity"])


func _on_Back_pressed():
	queue_free()
