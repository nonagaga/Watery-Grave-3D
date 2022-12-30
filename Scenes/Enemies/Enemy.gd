extends Spatial

onready var head = get_parent().get_node("Character/Head")

func _physics_process(delta):
	look_at(head.global_translation, Vector3.UP)
	
