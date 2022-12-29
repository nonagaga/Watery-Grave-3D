extends SpotLight

export var light_accel = 8
onready var head = get_parent().get_node("Character/Head")

func _physics_process(delta):
	global_transform = global_transform.interpolate_with(head.global_transform, light_accel*delta)
